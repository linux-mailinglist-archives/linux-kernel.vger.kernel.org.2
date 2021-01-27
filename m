Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7973067A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhA0XQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234802AbhA0XOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611789205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pr6Co7ntJ1/liHxJICICBCAntdg2dYIVuYNiuoPSsbc=;
        b=HURBjrt8Clp9yCneNnvbtbVqS7e/UshdQuL1BfJdqUAGe2gdoVQKHeENaMwNIQsthU1Icz
        OY74NLV+DxZ0WOv8dmBEB0GoSPrdEuYa5eibVeZhebqJhwHrd3IwQ/QyT/OC3/dFU6UJEl
        TuFbcb6G8OOFWcBC3okOqMjVmaapzSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-uKk1FXqGMLaoZEWpVyVdDA-1; Wed, 27 Jan 2021 18:13:21 -0500
X-MC-Unique: uKk1FXqGMLaoZEWpVyVdDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75D0F801AA7;
        Wed, 27 Jan 2021 23:13:19 +0000 (UTC)
Received: from krava (ovpn-112-48.ams2.redhat.com [10.36.112.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6EEAC10023B3;
        Wed, 27 Jan 2021 23:13:17 +0000 (UTC)
Date:   Thu, 28 Jan 2021 00:13:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH 1/2] perf script: Support filtering by hex address
Message-ID: <20210127222905.GD284633@krava>
References: <20210124232750.19170-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124232750.19170-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 07:27:49AM +0800, Jin Yao wrote:

SNIP

>  	perf script --symbols=noploop,0x4007a0
>  
> +	Support filtering trace records by symbol name, start address of
> +	symbol, any hexadecimal address and address range.
> +
> +	The comparison order is:
> +	1. symbol name comparison
> +	2. symbol start address comparison.
> +	3. any hexadecimal address comparison.
> +	4. address range comparison (see --addr-range).
> +
> +--addr-range::
> +	Use with -S or --symbols to list traced records within address range.
> +
> +	For example, to list the traced records within the address range
> +	[0x4007a0, 0x0x4007a9]:
> +	perf script -S 0x4007a0 --addr-range 10
> +
>  --call-trace::
>  	Show call stream for intel_pt traces. The CPUs are interleaved, but
>  	can be filtered with -C.
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index edacfa98d073..e0feda33dbb9 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3525,6 +3525,8 @@ int cmd_script(int argc, const char **argv)
>  		    "system-wide collection from all CPUs"),
>  	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
>  		   "only consider these symbols"),
> +	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
> +		    "Use with -S to list traced records within address range"),
>  	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
>  			"Decode instructions from itrace", parse_insn_trace),
>  	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index fbe8578e4c47..525b859cb445 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -645,6 +645,22 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
>  	return al->sym;
>  }
>  
> +static bool check_address_range(struct strlist *sym_list, int addr_range,
> +				struct addr_location *al)
> +{
> +	struct str_node *pos;
> +	char *endptr;
> +	u64 addr, al_addr = al->map->unmap_ip(al->map, al->addr);
> +
> +	strlist__for_each_entry(pos, sym_list) {
> +		addr = strtoull(pos->s, &endptr, 16);
> +		if (al_addr >= addr && al_addr < addr + addr_range)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * Callers need to drop the reference to al->thread, obtained in
>   * machine__findnew_thread()
> @@ -709,6 +725,26 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  			ret = strlist__has_entry(symbol_conf.sym_list,
>  						al_addr_str);
>  		}
> +		if (!ret && al->map) {
> +			snprintf(al_addr_str, sz, "0x%"PRIx64,
> +				al->map->unmap_ip(al->map, al->addr));
> +			ret = strlist__has_entry(symbol_conf.sym_list,
> +						 al_addr_str);
> +			if (!ret) {
> +				/* Check for hex without "0x" prefix */
> +				snprintf(al_addr_str, sz, "%"PRIx64,
> +					al->map->unmap_ip(al->map, al->addr));
> +				ret = strlist__has_entry(symbol_conf.sym_list,
> +							 al_addr_str);
> +			}

that seems tricky.. what if user specify more leading zeros,
I think it'd be better to search intlist instead

we could move all 'address' entries from sym_list to
new intlist (in symbol__init) and use it for this search

jirka

