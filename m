Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8242992F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhJKV4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhJKV4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:56:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935EC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:54:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y3so27369615wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bDHYnKA2ppG3wjOjjKjo37Uayl924L2DcQk7LMht4jI=;
        b=mbIpyRfykmfferdbjZNmtqK/brQzSgFRPV1r80JTcbZgwUA3xKeoJExJnJTHQyW0Ai
         HFEv6Xls/YciilQEXPFqJgFoBot1quirs2JQCO6M3rDqq5q8DMyhj9g7ezhDwfGh3SAM
         lL3kesExb9VzG17/N3gVYID5yLnY24viS0PHXQucvm1XicVEt0lx7+HKikrql9crFDPr
         dcsgGUBW3dRdOVRjN1dnc2tLqybIcO+9jaZhP2oFH912DKnKMTzK5MK87/iO6snEo8Db
         PyjaYcygza5i8PhCQLw6x0j0XLMltHu7ASIuzZVTnSV2un8ml1xBNGmMi27/GjIQ8H1O
         2ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bDHYnKA2ppG3wjOjjKjo37Uayl924L2DcQk7LMht4jI=;
        b=vh0/loMAoAtNm3C67OTEFuMY1Mf5oRsOx926sDep3WP0pcQtdTDyEnOj/GesiOqsqJ
         +waZT7QaQhiBzj3ya9VaaMar/A6PdpVc+zoD9F3BjgKcSq0xvhQvnfaexMsJzWyzjC78
         zjUZ/W8X5L1Ig1ejZk9S5XicQ3xv0XRWoKPUourBHiOtsFxpEGMQK33xvdR3Mwx3MV2l
         p6A5C5M+wyrICPM48TvUOacjXdKkIB8wMmlkN0TsDDOHaIrrv2+34Jc5WACjmAseX+JP
         lvgSvyeKxNe9vPyahxTCzIKpSf7HyYhpFM2u58gfQGGdxwvhsy1OcJIDrNdrXNAER2Hv
         znUA==
X-Gm-Message-State: AOAM531l1jxQzxZCAWW0F76fWgKJsoSu499EpX2AuCU6Eq2G/SCvt3uA
        K45NUxEgnX4QrbD8QWRqP0ETbViewKL1B2o4
X-Google-Smtp-Source: ABdhPJw8Jyh0nHXNGj9nkBDShxqKHEWeO5WndGq5QTk7ftnTCS58wi/tmZ/LqnPUjt9LQiBVn3pfAA==
X-Received: by 2002:a1c:540e:: with SMTP id i14mr1624645wmb.100.1633989292455;
        Mon, 11 Oct 2021 14:54:52 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c7:8d80:41b2:6091:e6eb:9c88? ([2a02:8084:20c7:8d80:41b2:6091:e6eb:9c88])
        by smtp.gmail.com with ESMTPSA id 36sm8856652wrc.92.2021.10.11.14.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 14:54:51 -0700 (PDT)
Subject: Re: [PATCH v2] staging: r8188eu: Fix misspelling in comment
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <7bc392d5-11e4-7ad0-dab6-295ccadf63b9@gmail.com>
 <YVwpEa5T4HnOX5/g@kroah.com> <f1569e97-8996-e538-182c-cc5f6510dc35@gmail.com>
 <35a358c67c6220825b37e64c6aa2978741565bdd.camel@perches.com>
From:   "Siou-Jhih, Guo" <hallblazzar@gmail.com>
Message-ID: <7fc8382e-629c-b271-d20d-e668d0f9690e@gmail.com>
Date:   Mon, 11 Oct 2021 22:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <35a358c67c6220825b37e64c6aa2978741565bdd.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/10/2021 02:02, Joe Perches wrote:
> On Tue, 2021-10-05 at 22:16 +0100, Siou-Jhih, Guo wrote:
>> If anything should I additionally aware, I'd like to fix them.
>
> Maybe fix these too?
>
> $ git grep -w -i -P -n 'issuign|fittign|settign|enablign|followign|chargign|beign|startign|accordign|runnign'
> arch/arm/mach-s3c/sleep-s3c64xx.S:33:    * requires to get the kernel runnign again. This code expects to be
> drivers/crypto/ccree/cc_driver.c:278:   /* AXI interrupt config are obsoleted startign at cc7x3 */
> drivers/hid/hid-thrustmaster.c:80: * beign conducted yet. The position and meaning of fields are a
> drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h:809: * our own HELLO may get lost if it happens right as the MASTER is issuign a
> drivers/net/ethernet/qlogic/qede/qede_filter.c:2029:    /* Translate the flow specification into something fittign our DB */
> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:1158: * Overview:   88E change all channel tx power accordign to flag.
> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:1837: * Overview:   88E change all channel tx power accordign to flag.
> drivers/power/supply/ab8500_charger.c:1325: * ab8500_charger_led_en() - turn on/off chargign led
> drivers/power/supply/ab8500_charger.c:1327: * @on:              flag to turn on/off the chargign led
> drivers/spi/spi-tegra20-slink.c:543:            /* HW need small delay after settign Packed mode */
> drivers/staging/media/atomisp/pci/runtime/bufq/src/bufq.c:412:   * by some test apps. Enablign logging here floods the log
> drivers/staging/media/atomisp/pci/runtime/bufq/src/bufq.c:434:   * by some test apps. Enablign logging here floods the log
> drivers/staging/r8188eu/core/rtw_ap.c:747:Set to 0 (HT pure) under the followign conditions
> drivers/staging/r8188eu/hal/HalPhyRf_8188e.c:72: * Overview:    88E change all channel tx power accordign to flag.
> drivers/thermal/tegra/soctherm.c:844:    * programmed on a different one. This beign a LEVEL interrupt won't
> drivers/usb/gadget/function/f_hid.c:312:         * Remove this from list to protect it from beign free()
> net/mac80211/mesh_plink.c:1077:                  * B's peer link establishment or B beign
>
>

Hello Joe,

Thanks for your advice. It sounds really great. But this is my very
first patch, and I'm not sure adding so many modifications is proper or
not ... Maybe I could contribute after I could successfully pass my
first patch?

Regards,
Bill G.

