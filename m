Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7230FF06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBDVCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBDVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:02:17 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6963C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:01:36 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id w1so7867850ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s/yIzssAJEogX8QL3PckAQf7VpPhtvWTp1CrCg9cJI=;
        b=LVKt1Jlg3viOJCnY9KgBaZrpObq3g8tFou+0PefdJnZLo6tvXDeCkMkUhDvJZ07B3g
         lTidacUKRZ1vCypk6VTJ5SuTfea3fUaMCdK9Bv8rmr6R/sOHmhRwtZrtxrUoWAo4absE
         m9RM2D02QLapaVpgAI6iyiLk48DoxHPiWNys7RIl+4fPi1YAqxCWWyoaOecXPrIHAXZ5
         hDIRSUEeOz0OSO+pSEfJ1sf+M5TKBhUA6UHdbSMVd+l+GXCRHLNVE3q7aTpK8zJkluMT
         hfc+Jgi+5RjaJX8OAeCcCvAxwMeDCMboKnHsWrWkYRtZq15chxB+vgbbT3QWMcyKsf6M
         lkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s/yIzssAJEogX8QL3PckAQf7VpPhtvWTp1CrCg9cJI=;
        b=c+/zI+TmUefZSz2V663ZDehTvQcqSeC3dGLJPeJ8wyun5sS1EaipW265dV56YNgeLc
         QiFQD2TpnCx1a3NPj0DSJ4SmX/A/wxP5txMWQaTXdKJdgufRwL7is0LRoHEj8tTaXCZy
         DpxSm1QZndQjHnQtLyuJ5BZ0XPTZc3Dt2zZwLMd8jYaDiqJkWLTxfnapB+7CEw2Mwh0W
         XA5kRfZbrZp0dP26CZNUULuYHmz0Y0XbakHavAJqcd4WZYOh6832mEQbycr1/nonToZ6
         CSdWWEoNSU/9PiLZwmsj5EzkkS97sCubuQyEby2E2pCjBKCSkyrxwkRSaDSfkpW7DTbu
         l4yw==
X-Gm-Message-State: AOAM530yY2zeoUWQe+k0zahLPCt6ZvsE3ktP3Q2YwEzKSv5ROjEBsjxy
        exYzJEgZO6o661kV/Kg7LzoVeFk6JRD0zWe4SAqmwQ==
X-Google-Smtp-Source: ABdhPJyHp/zY/gWK0OHwxd1OKIX/x+WfdHoU/hR/Dv5qm54B4zuu4eKGOX6BEyUFFddG59yitMp3iDRQpdDKA7E6P3w=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr920058ejb.523.1612472495097;
 Thu, 04 Feb 2021 13:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com> <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com> <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
 <20210203171610.2y2x4krijol5dvkk@intel.com> <YBroGrVd76p+BF0v@Konrads-MacBook-Pro.local>
 <CAPcyv4hMM9isho5d8wS=5vtP0NxE5KA0HrMp+Bx2PZhPDrrWsg@mail.gmail.com> <20210204185540.oxwurggwd7a37a2o@intel.com>
In-Reply-To: <20210204185540.oxwurggwd7a37a2o@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Feb 2021 13:01:35 -0800
Message-ID: <CAPcyv4jmZ_NcR4yX2mMV6qkhxkKvg3qYenkQGPcF1TvvFXf-oQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 10:56 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> It actually got pushed into cxl_mem_raw_command_allowed()
>
> static bool cxl_mem_raw_command_allowed(u16 opcode)
> {
>         int i;
>
>         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
>                 return false;
>
>         if (security_locked_down(LOCKDOWN_NONE))
>                 return false;
>
>         if (raw_allow_all)
>                 return true;
>
>         if (is_security_command(opcode))
>                 return false;
>
>         for (i = 0; i < ARRAY_SIZE(disabled_raw_commands); i++)
>                 if (disabled_raw_commands[i] == opcode)
>                         return false;
>
>         return true;
> }
>
> That work for you?

Looks good to me.
