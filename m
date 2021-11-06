Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C0D447051
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 21:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhKFUFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 16:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233477AbhKFUFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 16:05:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C032F60EE9;
        Sat,  6 Nov 2021 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636228950;
        bh=UWK/1Ut2+nkoRQjPT3vwmn/To1ytATaqaVXfznRjdlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfaJGUvxpY8YbFfehpCqd9hBT6I4WMuGXsYzcymhd4kNUdYVuvWa9RFw44VmiJF2W
         ao3RaIoMewfVhTH/dhcRxUs47mC8znkOPh0MgtlgHXCCrVqhJ5AVXMbmQuoIgCPNQp
         whxPURbl8oWA+A18nCc5RfjftjEqz4/6+w5XL1hNcQYGwinnABEQ3ZS5iiPVEqnNCC
         Aa6OmKWgXMYIypYFvC6HXJEuKx4/Tac4HCeFRv+ys2FjKtSTbN159XbqwvE9EGLbDj
         k4YTAi+uLpuw8Xbu20rWptoSlLehDYK8+sd0h6SuUchay0rkZ/PxVuovZaWTfGtbnT
         EFBnnTNqrRYvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5BB0A410A1; Sat,  6 Nov 2021 17:02:27 -0300 (-03)
Date:   Sat, 6 Nov 2021 17:02:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf: Use __BYTE_ORDER__
Message-ID: <YYbfUxEe3D3oMePU@kernel.org>
References: <20211104132311.984703-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104132311.984703-1-iii@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 04, 2021 at 02:23:11PM +0100, Ilya Leoshkevich escreveu:
> Switch from the libc-defined __BYTE_ORDER to the compiler-defined
> __BYTE_ORDER__ in order to make endianness detection more robust, like
> it was done for libbpf.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c    | 2 +-
>  tools/perf/util/data-convert-bt.c                        | 2 +-
>  tools/perf/util/genelf.h                                 | 2 +-
>  tools/perf/util/intel-bts.c                              | 2 +-
>  tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 2 +-
>  tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c  | 2 +-
>  tools/perf/util/s390-cpumsf.c                            | 8 ++++----
>  7 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 2e5eff4f8f03..2f311189c6e8 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -13,7 +13,7 @@
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> -#if __BYTE_ORDER == __BIG_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  #define le16_to_cpu bswap_16
>  #define le32_to_cpu bswap_32
>  #define le64_to_cpu bswap_64
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index aa862a26d95c..8f7705bbc2da 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -1437,7 +1437,7 @@ static struct bt_ctf_field_type *create_int_type(int size, bool sign, bool hex)
>  	    bt_ctf_field_type_integer_set_base(type, BT_CTF_INTEGER_BASE_HEXADECIMAL))
>  		goto err;
>  
> -#if __BYTE_ORDER == __BIG_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  	bt_ctf_field_type_set_byte_order(type, BT_CTF_BYTE_ORDER_BIG_ENDIAN);
>  #else
>  	bt_ctf_field_type_set_byte_order(type, BT_CTF_BYTE_ORDER_LITTLE_ENDIAN);
> diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> index d4137559be05..3db3293213a9 100644
> --- a/tools/perf/util/genelf.h
> +++ b/tools/perf/util/genelf.h
> @@ -42,7 +42,7 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
>  #error "unsupported architecture"
>  #endif
>  
> -#if __BYTE_ORDER == __BIG_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  #define GEN_ELF_ENDIAN	ELFDATA2MSB
>  #else
>  #define GEN_ELF_ENDIAN	ELFDATA2LSB
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index af1e78d76228..2c8147a62203 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -35,7 +35,7 @@
>  #define INTEL_BTS_ERR_NOINSN  5
>  #define INTEL_BTS_ERR_LOST    9
>  
> -#if __BYTE_ORDER == __BIG_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  #define le64_to_cpu bswap_64
>  #else
>  #define le64_to_cpu
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> index 593f20e9774c..9d5e65cec89b 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> @@ -143,7 +143,7 @@ static void intel_pt_insn_decoder(struct insn *insn,
>  
>  	if (branch == INTEL_PT_BR_CONDITIONAL ||
>  	    branch == INTEL_PT_BR_UNCONDITIONAL) {
> -#if __BYTE_ORDER == __BIG_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  		switch (insn->immediate.nbytes) {
>  		case 1:
>  			intel_pt_insn->rel = insn->immediate.value;
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> index 02a3395d6ce3..4bd154848cad 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> @@ -16,7 +16,7 @@
>  
>  #define BIT63		((uint64_t)1 << 63)
>  
> -#if __BYTE_ORDER == __BIG_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  #define le16_to_cpu bswap_16
>  #define le32_to_cpu bswap_32
>  #define le64_to_cpu bswap_64
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index 8130b56aa04b..f3fdad28a852 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -244,7 +244,7 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
>  				   struct hws_basic_entry *basicp)
>  {
>  	struct hws_basic_entry *basic = basicp;
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	struct hws_basic_entry local;
>  	unsigned long long word = be64toh(*(unsigned long long *)basicp);
>  
> @@ -288,7 +288,7 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
>  				  struct hws_diag_entry *diagp)
>  {
>  	struct hws_diag_entry *diag = diagp;
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	struct hws_diag_entry local;
>  	unsigned long long word = be64toh(*(unsigned long long *)diagp);
>  
> @@ -322,7 +322,7 @@ static unsigned long long trailer_timestamp(struct hws_trailer_entry *te,
>  static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
>  				     struct hws_trailer_entry *te)
>  {
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	struct hws_trailer_entry local;
>  	const unsigned long long flags = be64toh(te->flags);
>  
> @@ -552,7 +552,7 @@ static unsigned long long get_trailer_time(const unsigned char *buf)
>  	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
>  					      - sizeof(*te));
>  
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	clock_base = be64toh(te->progusage[0]) >> 63 & 0x1;
>  	progusage2 = be64toh(te->progusage[1]);
>  #else
> -- 
> 2.31.1
> 

-- 

- Arnaldo
