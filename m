Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB954368B98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhDWDb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbhDWDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:31:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A319C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y62so531691pfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=oA6uUurtMU8w7TYacXD4ktf3tQXYmIfvhBvbbuCMgLg=;
        b=jAWMKXNs00Whsb1gKP4JLGMWKl2ami5WHvugNAa2ujA4Kv1uqqLAt2scV/d5GV8AXb
         sLDH1zOKXfBpg41ZNS6GKIvZtvBo7DCP2RlAfa5PpiWQZEX/V1Fx5UcLfPmqCOmlQK1J
         Ovu5eEHaXyE9bwU5g0D6bSnI+dqh6/O61fZBK0XAKEfau+RigVXOx7rIl/cAdlQwVM1/
         srmzcMz8FK9U5SoEzYc8bB8rKTpQIffhdy3jCtPW6UlJgFbW50+VgvVjRzzqK2aL9Omu
         OwpXfVNQajauxxbu3iq3WpYFQwb6cD2K4pUcTxf22OkDZEvvKJDWItV2+qOO//JBuvhv
         42tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=oA6uUurtMU8w7TYacXD4ktf3tQXYmIfvhBvbbuCMgLg=;
        b=cfOI0UMqwL3ZdBRCNqDYAWVuQ+8kCqoV7e3fsiB6KGuSQWEHa2kyPbhlQ8Is2QkGii
         9UIkLKzu2ngtiv05+mL1/EL/vTraBspXdkrWmCDdS5xz8r05517xQ87Ip/b3fRYHIsHT
         dPUq/NSlQainV8vcdsYHs6X+gx1ae22xUQX4e/uN+P53LVhm8FXy02NKz4TNhbW6QmBX
         65tOfWbdaDSzlilNR70YysaG8VUlBvU2zMxRgMynxjQxgNUFFxG+EOoyzheAJ0CJ6q+o
         UdAlYzs/STzkKqGAs5eVh3jkknCdjB3gI3D/6768MSYqNowtf6lucmB4BcnKefyyXOY6
         ngkw==
X-Gm-Message-State: AOAM53183fkPJ6vN1DLY8ORNlzXu2ZjoHP8dnRS+pqZO95DrCsJLzD/4
        artqjCB1OFy4X3Frb9LXlg2Zbw==
X-Google-Smtp-Source: ABdhPJwqlzAMe93JD/qSyfcM3dDhNq1vg2/xGFgU0QpmCCQp6zF5/O11volIEFPMtNWEj7Q3aoXJzA==
X-Received: by 2002:a63:40c1:: with SMTP id n184mr1765795pga.219.1619148645875;
        Thu, 22 Apr 2021 20:30:45 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n23sm3388570pgl.49.2021.04.22.20.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 20:30:45 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:30:45 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 20:23:16 PDT (-0700)
Subject:     Re: [PATCH v3 1/5] RISC-V: Add EM_RISCV to kexec UAPI header
In-Reply-To: <20210405085712.1953848-2-mick@ics.forth.gr>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, mick@ics.forth.gr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr, ebiederm@xmission.com, kexec@lists.infradead.org
Message-ID: <mhng-891ba63b-523a-470d-9e50-a881b9e3dde1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Apr 2021 01:57:08 PDT (-0700), mick@ics.forth.gr wrote:
> Add RISC-V to the list of supported kexec architecturs, we need to
> add the definition early-on so that later patches can use it.
>
> EM_RISCV is 243 as per ELF psABI specification here:
> https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md
>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> ---
>  include/uapi/linux/kexec.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 05669c87a..778dc191c 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -42,6 +42,7 @@
>  #define KEXEC_ARCH_MIPS_LE (10 << 16)
>  #define KEXEC_ARCH_MIPS    ( 8 << 16)
>  #define KEXEC_ARCH_AARCH64 (183 << 16)
> +#define KEXEC_ARCH_RISCV   (243 << 16)
>
>  /* The artificial cap on the number of segments passed to kexec_load. */
>  #define KEXEC_SEGMENT_MAX 16

This is missing the kexec maintainers, who I've added.  I'm happy to 
just take this along with the rest of the patch set, as that's probably 
easiest.  I usually like to get an Ack on this sort of thing, but I'm 
just going to speculate that this isn't controversial and put this on 
riscv/for-next.  LMK if you want me to do something more complicated 
like a shared tag, but I see the arm64 stuff went in via the arm64 tree 
so I'm assuming this is fine.

Thanks!
