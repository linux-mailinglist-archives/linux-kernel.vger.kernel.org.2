Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBEF3065C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhA0VLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhA0VLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:11:00 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EEC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:10:19 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z9so2552165qtv.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzwS53hppY7KPc7vGcuoFqmg9FK5PaziyQ/eQVgEal4=;
        b=SQnZDNRvVBbh+emKyiy/PKMdl+WN5JHLvgLMelc+xFgduzE0rne4O78gsB25LZxO0U
         vIQy2fMjmHD8mKhHg5Aff+RaYituWlXbOKEtv5dGt7aySlQZvZicf2Iw3DnNZypHr7Vp
         WzUMCoCYRt7vLxQb+ZDKXa4Yce+GvXBPOm04N7CmZZnkYJTsbYMnfR4Bu1t+gHv8hCn+
         vl1RvO6PPzKpIjEluovcG/VVeuCqb+Cm6Z0WBV9lVvvQ62DBR1rTH/ZotYrg8qezJ0M0
         QWIKVSSPw1td3nNpq0VPEqpJGwpbejU7TNi6n5ZXHzl4YosExJbXUYXSAgn/+WwJHhUK
         o84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzwS53hppY7KPc7vGcuoFqmg9FK5PaziyQ/eQVgEal4=;
        b=cJeGYXlevLLP8Uv/AFOm0FYwAw5pvExSxQrxXFwwCaplEtt0YM+idNXYthbuawY6iC
         tmJnwjTI1omQkXCyuwHOt6KcTnyzlg7LDlvFkSd5uxcalWtrHYfpEnrJnBt3KLmdQ4BL
         pTrPb7wotO1HJ9clv9LE9i7QxlqWCAr5OWi+c3qc5TNvm79XRM4X1KfmAZcUsoxXtt15
         ynqaS9db2ip27LpcDbHal3lMweQqSFGlXp1OJd0PSAiCNZY+w4b+6rHH+5nqdJpN75vC
         2jru676U6+PYlTFRzYct8DLTz+ykYBsTbGw+MUC4df89u88tZHGwjDrWHx4ewsIgt0uZ
         HVJw==
X-Gm-Message-State: AOAM533dBE1Om72yClryS6EMzhMKIvvkWEBYT2s5X0J/kwZtLZh9GdhW
        1JLMobp3HB9AlVgHLYUmkjTvSk+ihx4/+yZ7o+woEA==
X-Google-Smtp-Source: ABdhPJxZhyyS6h96fIJdDpgX2+IeiW9gut+60Os4yoPBgeUvj17ld+YOTwC+3WGPuEnzGcMjZsT5KMh7qNozSC047/o=
X-Received: by 2002:ac8:480b:: with SMTP id g11mr1264756qtq.290.1611781818618;
 Wed, 27 Jan 2021 13:10:18 -0800 (PST)
MIME-Version: 1.0
References: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com>
 <YBG0glwiK1wyJTeN@Konrads-MacBook-Pro.local> <CACT4Y+a48smtXc6qJy9Wthwuqjk2gh6o7BK1tfWW46g7D_r-Lg@mail.gmail.com>
 <cc712c9c-7786-bb26-7082-04e564df98aa@oracle.com>
In-Reply-To: <cc712c9c-7786-bb26-7082-04e564df98aa@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jan 2021 22:10:07 +0100
Message-ID: <CACT4Y+bPDvmwk38DrKfGV8cbtS_abAMDCqr9OigcPfep0uk5AQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in ibft_init()
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, pjones@redhat.com,
        konrad@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 9:01 PM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Hi Dmitry,
>
> On 1/27/2021 1:48 PM, Dmitry Vyukov wrote:
>
> On Wed, Jan 27, 2021 at 7:44 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>
> On Tue, Jan 26, 2021 at 01:03:21PM -0500, George Kennedy wrote:
>
> During boot of kernel with CONFIG_KASAN the following KASAN false
> positive failure will occur when ibft_init() reads the
> ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init
>
> The ACPI iBFT table is not allocated, and the iscsi driver uses
> a pointer to it to calculate checksum, etc. KASAN complains
> about this pointer with use-after-free, which this is not.
>
> Andrey, Alexander, Dmitry,
>
> I think this is the right way for this, but was wondering if you have
> other suggestions?
>
> Thanks!
>
> Hi George, Konrad,
>
> Please provide a sample KASAN report and kernel version to match line numbers.
>
> 5.4.17-2102.200.0.0.20210106_0000
>
> [   24.413536] iBFT detected.
> [   24.414074]
> ==================================================================
> [   24.407342] BUG: KASAN: use-after-free in ibft_init+0x134/0xb8b
> [   24.407342] Read of size 4 at addr ffff8880be452004 by task swapper/0/1
> [   24.407342]
> [   24.407342] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.17-2102.200.0.0.20210106_0000.syzk #1
> [   24.407342] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [   24.407342] Call Trace:
> [   24.407342]  dump_stack+0xd4/0x119
> [   24.407342]  ? ibft_init+0x134/0xb8b
> [   24.407342]  print_address_description.constprop.6+0x20/0x220
> [   24.407342]  ? ibft_init+0x134/0xb8b
> [   24.407342]  ? ibft_init+0x134/0xb8b
> [   24.407342]  __kasan_report.cold.9+0x37/0x77
> [   24.407342]  ? ibft_init+0x134/0xb8b
> [   24.407342]  kasan_report+0x14/0x1b
> [   24.407342]  __asan_report_load_n_noabort+0xf/0x11
> [   24.407342]  ibft_init+0x134/0xb8b
> [   24.407342]  ? dmi_sysfs_init+0x1a5/0x1a5
> [   24.407342]  ? dmi_walk+0x72/0x89
> [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
> [   24.407342]  ? rvt_init_port+0x110/0x101
> [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
> [   24.407342]  do_one_initcall+0xc3/0x44d
> [   24.407342]  ? perf_trace_initcall_level+0x410/0x405
> [   24.407342]  kernel_init_freeable+0x551/0x673
> [   24.407342]  ? start_kernel+0x94b/0x94b
> [   24.407342]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
> [   24.407342]  ? __kasan_check_write+0x14/0x16
> [   24.407342]  ? rest_init+0xe6/0xe6
> [   24.407342]  kernel_init+0x16/0x1bd
> [   24.407342]  ? rest_init+0xe6/0xe6
> [   24.407342]  ret_from_fork+0x2b/0x36
> [   24.407342]
> [   24.407342] The buggy address belongs to the page:
> [   24.407342] page:ffffea0002f91480 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1
> [   24.407342] flags: 0xfffffc0000000()
> [   24.407342] raw: 000fffffc0000000 ffffea0002fca588 ffffea0002fb1a88 0000000000000000
> [   24.407342] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> [   24.407342] page dumped because: kasan: bad access detected
> [   24.407342]
> [   24.407342] Memory state around the buggy address:
> [   24.407342]  ffff8880be451f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [   24.407342]  ffff8880be451f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [   24.407342] >ffff8880be452000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [   24.407342]                    ^
> [   24.407342]  ffff8880be452080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [   24.407342]  ffff8880be452100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [   24.407342]
> ==================================================================
> [   24.407342] Disabling lock debugging due to kernel taint
> [   24.451021] Kernel panic - not syncing: panic_on_warn set ...
> [   24.452002] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B 5.4.17-2102.200.0.0.20210106_0000.syzk #1
> [   24.452002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [   24.452002] Call Trace:
> [   24.452002]  dump_stack+0xd4/0x119
> [   24.452002]  ? ibft_init+0x102/0xb8b
> [   24.452002]  panic+0x28f/0x6e0
> [   24.452002]  ? __warn_printk+0xe0/0xe0
> [   24.452002]  ? ibft_init+0x134/0xb8b
> [   24.452002]  ? add_taint+0x68/0xb3
> [   24.452002]  ? add_taint+0x68/0xb3
> [   24.452002]  ? ibft_init+0x134/0xb8b
> [   24.452002]  ? ibft_init+0x134/0xb8b
> [   24.452002]  end_report+0x4c/0x54
> [   24.452002]  __kasan_report.cold.9+0x55/0x77
> [   24.452002]  ? ibft_init+0x134/0xb8b
> [   24.452002]  kasan_report+0x14/0x1b
> [   24.452002]  __asan_report_load_n_noabort+0xf/0x11
> [   24.452002]  ibft_init+0x134/0xb8b
> [   24.452002]  ? dmi_sysfs_init+0x1a5/0x1a5
> [   24.452002]  ? dmi_walk+0x72/0x89
> [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
> [   24.452002]  ? rvt_init_port+0x110/0x101
> [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
> [   24.452002]  do_one_initcall+0xc3/0x44d
> [   24.452002]  ? perf_trace_initcall_level+0x410/0x405
> [   24.452002]  kernel_init_freeable+0x551/0x673
> [   24.452002]  ? start_kernel+0x94b/0x94b
> [   24.452002]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
> [   24.452002]  ? __kasan_check_write+0x14/0x16
> [   24.452002]  ? rest_init+0xe6/0xe6
> [   24.452002]  kernel_init+0x16/0x1bd
> [   24.452002]  ? rest_init+0xe6/0xe6
> [   24.452002]  ret_from_fork+0x2b/0x36
> [   24.452002] Dumping ftrace buffer:
> [   24.452002] ---------------------------------
> [   24.452002] swapper/-1         1.... 24564337us : rdmaip_init: 2924: rdmaip_init: Active Bonding is DISABLED
> [   24.452002] ---------------------------------
> [   24.452002] Kernel Offset: disabled
> [   24.452002] Rebooting in 1 seconds..
>
> Why does KASAN think the address is freed? For that to happen that
> memory should have been freed. I don't remember any similar false
> positives from KASAN, so this looks a bit suspicious.
>
> I'm not sure why KASAN thinks the address is freed. There are other modules where KASAN/KCOV is disabled on boot.
> Could this be for a similar reason?

Most of these files are disabled because they cause recursion in
instrumentation, or execute too early in bootstrap process (before
kasan_init).

Somehow the table pointer in ibft_init points to a freed page. I
tracked it down to here:
https://elixir.bootlin.com/linux/v5.4.17/source/drivers/acpi/acpica/tbutils.c#L399
but I can't find where this table_desc->pointer comes from. Perhaps it
uses some allocation method that's not supported by KASAN? However,
it's the only such case that I've seen, so it's a bit weird. Could it
use something like memblock_alloc? Or maybe that page was in fact
freed?... Too bad KASAN does not print free stack for pages, maybe
it's not too hard to do if CONFIG_PAGE_OWNER is enabled...



> Thank you,
> George
>
>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  drivers/firmware/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 5e013b6..30ddab5 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -14,6 +14,9 @@ obj-$(CONFIG_INTEL_STRATIX10_SERVICE) += stratix10-svc.o
>  obj-$(CONFIG_INTEL_STRATIX10_RSU)     += stratix10-rsu.o
>  obj-$(CONFIG_ISCSI_IBFT_FIND)        += iscsi_ibft_find.o
>  obj-$(CONFIG_ISCSI_IBFT)     += iscsi_ibft.o
> +KASAN_SANITIZE_iscsi_ibft.o := n
> +KCOV_INSTRUMENT_iscsi_ibft.o := n
> +
>  obj-$(CONFIG_FIRMWARE_MEMMAP)        += memmap.o
>  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
>  obj-$(CONFIG_FW_CFG_SYSFS)   += qemu_fw_cfg.o
> --
> 1.8.3.1
>
>
