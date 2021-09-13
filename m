Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB6409E38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbhIMUgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbhIMUgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:36:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F28FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:35:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id x11so23838890ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgXnoSQcAEqH9v+dYj27OqeP8dsCLRRfwu3WgTI42ko=;
        b=Ok/xbnGSe2rgiIoBmcrRfcVYoHXt5wdvgFrbgU6tT4+1AcorngG8oYzRGoiDiBdNWv
         /jOboQ1xht6O8+AzO14iRZBlxvCKloeW6uFvtyhW2+XDzSRd3z0tSIImpUsZJtkzvT9+
         gNYbZvjOqpQiyJFeiEVPbp6+fPtDzL28q9NnjRv2OlqS8axlHKV0e4XLfOzitoaxcygC
         CRYcbrljHFSJr2MBQUTiNuTB4RjdsJORbElKVfjH58+6OSLq9H9Nn6WWvY0vdH+d6qi+
         a9Sxwd9gFInPSs5aFVPUNw0Z0R3UlGHW75rYsRGNyQaNW2dgqYjifvR+ecFlb2BYyJSY
         26NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgXnoSQcAEqH9v+dYj27OqeP8dsCLRRfwu3WgTI42ko=;
        b=6uOt9D6LLAFciLBiIvL9g6jLEreO/1pvwKNNWDHmSlj4oCo94sqAEtAQ62imtI9b5p
         KqaIxyxD77yPsjTr2H7Q17UJpuo8j6Uy4VaH7Nvgy63bA0ZqTBCDGPT2EwD+3PiRAada
         dZ+A8VS0ePqG8ik+BnUMTJgFvXpcNcheuv+S4wKsV7n1i25o7N8uwM51SRWhFdoc0sXU
         waLYA/ErPblkA9wA0grfJcKLEEy6Y5NwwyjM4MbaZUfKnaEEkAWgh+ZFJKqJE4iV2Gpg
         egiSM9Oz+ahzT1DtQ0qyzOpp0mMvB0QONSwGw09c1njNmgTXpy/AxLU1fFDQ/LVa1RXq
         8/vw==
X-Gm-Message-State: AOAM533+TUT3Cu8EhwfN1uGfz7CsIWcF42ApPDG97X0a0DPd3G4m3r13
        Wo7ZXXLRo2cy5KmLVAMgbdU=
X-Google-Smtp-Source: ABdhPJyGDNRU3xn+hzVVzl3+h5HmcuWIv18YW5/6T0fOvKTBb2aOrNbdvM3jXIt2/bixZhrO8lrp7A==
X-Received: by 2002:a17:906:2655:: with SMTP id i21mr8898921ejc.15.1631565326093;
        Mon, 13 Sep 2021 13:35:26 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id q9sm3914785ejf.70.2021.09.13.13.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:35:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH v4 00/18] staging: r8188eu: Shorten and simplify calls chain
Date:   Mon, 13 Sep 2021 22:35:22 +0200
Message-ID: <3628124.EQXE2LdQPN@localhost.localdomain>
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 13, 2021 8:09:44 PM CEST Fabio M. De Francesco wrote:
> io_ops abstraction is useless in this driver, since there is only one ops
> registration. Without io_ops we can get rid of indirect calls mess and
> shorten the calls chain.
> 
> Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> For this purpose unify the three usb_read8/16/32 into the new
> usb_read(); make the latter parameterizable with 'size'; embed most of
> the code of usbctrl_vendorreq() into usb_read() and use in it the new
> usb_control_msg_recv() API of USB Core.
> 
> Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
> For this purpose unify the four usb_write8/16/32/N() into the new
> usb_write(); make the latter parameterizable with 'size'; embed most of
> the code of usbctrl_vendorreq() into usb_write() and use in it the new
> usb_control_msg_send() API of USB Core.
> 
> The code with the modifications was thoroughly tested by Pavel Skripkin
> using a TP-Link TL-WN722N v2 / v3 [Realtek RTL8188EUS] and by Fabio M.
> De Francesco using a ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano].

Hi all,

Please disregard this series. I've made a mistake, so tomorrow I'll send v5.

Pavel Skripkin made me notice a logical error where the code checks errors in 
17/18 and 18/18. So, two lines must be rewritten.

Thanks,

Fabio


