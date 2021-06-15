Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C83A73E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhFOC1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhFOC1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:27:35 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651B2C061574;
        Mon, 14 Jun 2021 19:25:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id u30so40528739qke.7;
        Mon, 14 Jun 2021 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWnRdMbzlZ6uCg7kHZeS+mvPo3u6fozJ1gqjgHsyntI=;
        b=Euy4kMNQAlanaDv3HRhIEsHzxm91ku2c5m4d+B6e+Fn3yuOlPYPBOy/4jYmPapq+FH
         sEySXpcOGBuK2bxv79MRMRn2RXEGF7t5Ia2zw4PbIefMgbfsbYH6kRu+xDujLPlxr/n3
         Hl6P5pFW4mSXu6mEk2MZXkI+jDwsFtYwF2Zgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWnRdMbzlZ6uCg7kHZeS+mvPo3u6fozJ1gqjgHsyntI=;
        b=ZzkIG4oxhz0Pc43y4zA20IPEh+Az2lSFTf90AdVOEbKQ/aXvSQO87EiFLekSzLjuVA
         TkCZWBDM1OVbmnF59ACsBaKn2j0csO1Ce6+diQHvSN3GUtSS9SToeRp0CxJqqBUNrBB1
         lUShCu81mPMDdPsOno/oUC2EJvuvhSiHFQK90wXsdrFi75SHVcsr+2y6xkCi2IW3Xl4L
         m2S/XD6w0qTdMLF5AnWPdSXrP3NDXaGg2UavabAhHGhs0EPZnG7Wrt/9mOWvWCvp9SC0
         dMi/VtdzI+wd3lfi73GWnsc5EIxld/hFEGF1o+lhJVBXcWFj30pPMOYIu3nn5stRioDz
         W2cg==
X-Gm-Message-State: AOAM530bceICy6vfKk5FteYqOWjJ6kIf0JQQX/gxT/PEde45Jw6H558x
        n6Sn24ZUiF1k6/8d0AsaiN8LVIAcJU2qUsI0eViEvkP5
X-Google-Smtp-Source: ABdhPJylWwTMT1km2sa1BNaT0ATeITR5ItXM/dCgRFMmqLyJFBk85MzUpVFQfZT5ilFgEOotQH+KnaCtXRPVb0QGNFY=
X-Received: by 2002:a37:9b03:: with SMTP id d3mr18571270qke.273.1623721926602;
 Mon, 14 Jun 2021 18:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210612003128.372238-1-leoyang.li@nxp.com>
In-Reply-To: <20210612003128.372238-1-leoyang.li@nxp.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 15 Jun 2021 01:51:54 +0000
Message-ID: <CACPK8XfUiiBM=KQiqSJ5uSUpOHLTp_wxhNyEw-gYkTBsZjbZVg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: fsl: properly remove remnant of MXC support
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, ran.wang_1@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 at 00:31, Li Yang <leoyang.li@nxp.com> wrote:
>
> Commit a390bef7db1f ("usb: gadget: fsl_mxc_udc: Remove the driver")
> didn't remove all the MXC related stuff which can cause build problem
> for LS1021 when enabled again in Kconfig.  This patch remove all the
> remnants.
>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Will you re-submit the kconfig change once this is merged?

Cheers,

Joel
