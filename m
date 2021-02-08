Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF631421B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbhBHVmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbhBHVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:09:18 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3982C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 13:08:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 8so8495178plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 13:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJm8/HDh14/f+tvsioH0OsNm+NiMBDPt1A1hbcOg0gk=;
        b=qA9gL7bax5VaTfb1Q9le4KTA55ZfmYpH0hVaoV/PU5clxXs5TH6zlJsJ6o3iNmMc2p
         ugjId/IW5Cb2ocoyafHz7IB/3r1P3I2/n42iFdtZ9dviXc/012e+M8t6tcK9bt5VE4ZX
         Tf/opz3MzVjFq8hJR9kO9eealXMb4730WNixibvjK5L9DigF1E5JQZn+0UssADzrTuzv
         8/ZArRt5kZQYb3NJO4BuTfXLAz8aolJ+BdVt94HKJFyJJgnuTMe5xXaEZu3wNAYY+45V
         WwYfEf9ZH7RO3WpH5m4NaatvvD0MSTniosvaP+OgBkdf4Iq0+vGXZLfalExQSuBcIYQy
         bQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJm8/HDh14/f+tvsioH0OsNm+NiMBDPt1A1hbcOg0gk=;
        b=i4Lad0ISoAyN+mFei28rVHrzEWs1Kz+CXt8VZShbQ62nBTFM+1i3jRzBPXIEWZXW7L
         3EutH1H+rJIkf5t5oo7T4xDhCwB8q963xpe6toPoYLqcOdeIAc50p84m1DWyyGLXi10W
         bTBAgf2fzgTMkd9LE+LwwIiCr1t1P1h78zakLCTT96BB/3cRdj6x8duCcOXU4iUE1xs5
         SpciiXz86F+sWVLRZDxroqd/TrllgcGmibi7XQmcaRReMGe79MfVNs5O29ANBrwWciQD
         HLcxuxJ3Qo19L+KM7Lmk7PBFHSvu2KxnRWmeAY8nAj2F0n44OiHmJo8tzDIy8zps4iBX
         rsqQ==
X-Gm-Message-State: AOAM531wdQBZJIO3nlRIKz45fQn/sRyKIoZvsy4Y65QtRJrBc9K+VYmQ
        67AzsObpX2BBVqLt0udMI/A=
X-Google-Smtp-Source: ABdhPJy0MkXjn1dSSn/gaCaXWvjjnzPKS1eo6r6pTqGzH5m/3fFoP4yGSNUtV30YcgrVm2fAXKyisQ==
X-Received: by 2002:a17:90b:611:: with SMTP id gb17mr699915pjb.192.1612818518410;
        Mon, 08 Feb 2021 13:08:38 -0800 (PST)
Received: from localhost (g186.222-224-165.ppp.wakwak.ne.jp. [222.224.165.186])
        by smtp.gmail.com with ESMTPSA id t21sm4185317pfe.174.2021.02.08.13.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:08:37 -0800 (PST)
Date:   Tue, 9 Feb 2021 06:08:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Cc:     geert@linux-m68k.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Use devicetree to determine present cpus (v2)
Message-ID: <20210208210835.GO2002709@lianli.shorne-pla.net>
References: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jan,

I was able to take these 2 mails and merge them together to a single patch.

I will send the result for review in a bit.

Next time please learn some git/linux kernel developer basics.  It will
help make this more smooth inthe future.  THe code changes you made were great
and I hope to see more in the future. :)

Some tips:
  - Use 'git rebase -i', and the fixup/squash command to merge two or more
    commits.  Also, there you should add the summary as you did in your mail
    in the git commit message.
  - Use 'git format-patch -o patch-dir -v2 <batch-base-commit-id>' to create
    your patch.
  - Use './scripts/checkpatch.pl patch-dir/<patch-name>.patch' to check your
    patch before you send it.  If any issues use 'git rebase' or 'git commit
   --amend' to fix up the checkpatch issues then test and create a new patch.
  - Use './scripts/get-maintainers.pl' with 'git send-email' like this below.

Some links:
  - https://www.kernel.org/doc/html/latest/process/submitting-patches.html
  - http://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/
    (explains --cc-cmd, you can also add --no-rolestats to .get_maintainer.conf`
  - https://thoughtbot.com/blog/git-interactive-rebase-squash-amend-rewriting-history
    (explain rebase squash fixup)


This is usually what I do after testing.

    $ git lo   # my custom alias: lo = log --pretty=format:'%C(yellow)%cd %C(green)%h %C(blue)%<(16)%aN%Creset %s %C(auto)%d%Creset' --decorate --date=short -n10
    2021-02-09 8f722f67452f Jan Henrik Weinstock openrisc: Use devicetree to determine present cpus  (HEAD -> or1k-5.12-updates)
    2021-01-25 2261352157a9 Stafford Horne   Merge remote-tracking branch 'openrisc/or1k-5.11-fixes' into or1k-5.12-updates  (shorne/or1k-5.12-updates, shorne/for-next, openrisc/for-next, for-next)
    2021-01-21 3706f9f76a4f Geert Uytterhoeven drivers/soc/litex: Add restart handler
    2021-01-20 031c7a8cd6fc Geert Uytterhoeven openrisc: io: Add missing __iomem annotation to iounmap()  (shorne/or1k-5.11-fixes, openrisc/or1k-5.11-fixes, or1k-5.11-fixes)
    2021-01-18 803c72c8547c Masahiro Yamada  openrisc: add arch/openrisc/Kbuild
    2021-01-14 4f70d150294b Gabriel Somlo    drivers/soc/litex: make 'litex_[set|get]_reg()' methods private
    2021-01-14 51f109228308 Gabriel Somlo    drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
    2021-01-14 ffa4ebc48971 Gabriel Somlo    drivers/soc/litex: s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g
    2021-01-14 b5d3061ea2e6 Gabriel Somlo    drivers/soc/litex: separate MMIO from subregister offset calculation
    2021-01-14 9d93a9e8aab3 Gabriel Somlo    drivers/soc/litex: move generic accessors to litex.h

    $ git format-patch -v3 -o patches/ 2261352157a9
    patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch

    # Below a warning is printed but I think its OK as we can use NR_CPUS in smp.c
    $ ./scripts/checkpatch.pl patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
    WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
    #45: FILE: arch/openrisc/kernel/smp.c:73:
    +               if (cpu_id < NR_CPUS)

    total: 0 errors, 1 warnings, 45 lines checked

    NOTE: For some of the reported defects, checkpatch may be able to
	  mechanically convert to the typical style using --fix or --fix-inplace.

    patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch has style problems, please review.

    NOTE: If any of the errors are false positives, please report
	  them to the maintainer, see CHECKPATCH in MAINTAINERS.

    $ git send-email --to linux-kernel --cc-cmd ./scripts/get_maintainer.pl patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
    patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch

-Stafford

On Mon, Feb 08, 2021 at 03:28:32PM +0100, Jan Henrik Weinstock wrote:
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> ---
>  arch/openrisc/kernel/smp.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> index 75be7e34f..83cbf43d4 100644
> --- a/arch/openrisc/kernel/smp.c
> +++ b/arch/openrisc/kernel/smp.c
> @@ -61,32 +61,31 @@ void __init smp_prepare_boot_cpu(void)
>  
>  void __init smp_init_cpus(void)
>  {
> -	int i;
> +	struct device_node* cpu;
> +	u32 cpu_id;
> +
> +	for_each_of_cpu_node(cpu) {
> +		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> +			pr_warn("%s missing reg property", cpu->full_name);
> +			continue;
> +		}
>  
> -	for (i = 0; i < NR_CPUS; i++)
> -		set_cpu_possible(i, true);
> +		if (cpu_id < NR_CPUS)
> +			set_cpu_possible(cpu_id, true);
> +	}
>  }
>  
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	u32 cpu_id;
> -	struct device_node *cpu, *cpus;
> +	unsigned int cpu;
>  
>  	/*
>  	 * Initialise the present map, which describes the set of CPUs
>  	 * actually populated at the present time.
>  	 */
> -	cpus = of_find_node_by_path("/cpus");
> -	for_each_child_of_node(cpus, cpu) {
> -		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> -			pr_warn("%s missing reg property", cpu->full_name);
> -			continue;
> -		}
> -
> -		if (cpu_id >= max_cpus)
> -			continue;
> -
> -		set_cpu_present(cpu_id, true);
> +	for_each_possible_cpu(cpu) {
> +		if (cpu < max_cpus)
> +			set_cpu_present(cpu, true);
>  	}
>  }
>  
> -- 
> 2.17.1
> 
