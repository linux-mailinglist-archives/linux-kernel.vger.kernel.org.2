Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C113F559C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhHXCCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXCCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:02:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D10C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:01:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mf2so22451337ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJcK1jrVY4a0zfanTvm7jn/Cp34lV2SoXKYxTKCdE1M=;
        b=rb2ZJI6Vsah1Tlfuf1MARmIB4dJS1IqVLR+1L3KhHdxaQTLq9SPSUF+SLz4Prj3U7N
         7TQyUN29zG8P0/DLV/tG3+q5OpR2chKateMTf9AFvo8KpjVv4fZVi+4zct6lHO9/K2fX
         8y3qzNtGrUiPK45fV/bHRocVCld7KCKLGwUA5zHyHjHP5SN8jLTLk9pHB6krq/cYiQKe
         K742c1goJtMLOJeJP+UTiCCsc29N5YnX6l92qHjlROdvb2tVTbArO68G4NkDi+5w1XPC
         /NMcDWr6FhFDq0mqu1kkZi8DCpxFtc6nVFqYG1VIj7/aknxBHoGbSZFBdrRsoCUPco22
         mfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJcK1jrVY4a0zfanTvm7jn/Cp34lV2SoXKYxTKCdE1M=;
        b=HGTMHghdJsSjqXXhWLQL4iVzJtm/CnQ7Gx2/iR3Huh3LaBmJS0c54i2/6lPnzyE5P8
         TYu8VwSJ98YEUGruc8dlZ1TxT90IxkaqfMh6wbNis2YaP2fMIKaGiCBD7MVs3XJCanPc
         NmzhRAJjnR9j3U/gOuQV9o9PgdEmPZWJWWPh5b0KKF7cbaR8z/0bFKadl20w+ohlrIpy
         J+M8Neya2Sf3JWatxH5nzSPIxLcqJBTnQ7xnNfbj7LXbR96IQ0FUGdWbIO7OkWUWmAqN
         UALFdxrmWZQ6R/8UK9d7iWxTVUjb7mg6dR8n63KhuKT7NTHSZa/0ByJkHcFIXcz0mZCX
         9NtQ==
X-Gm-Message-State: AOAM532lmk4yOtXSBTzyRse+fU90Lrx3oDODGjIe6kJLGJXT1x1H/wtq
        Lh3h4Ra6nXT7xdT8/qMv2LQ=
X-Google-Smtp-Source: ABdhPJxED1RBUXtSJN1dGKfFovRwS9fCSe8+Bso+p5QGFfm+LFU+CwhraCb3XlwdrCPW2FxhcfdG9Q==
X-Received: by 2002:a17:906:9b53:: with SMTP id ep19mr13897879ejc.86.1629770487919;
        Mon, 23 Aug 2021 19:01:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id p23sm10615239edw.94.2021.08.23.19.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:01:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 04:01:26 +0200
Message-ID: <4118209.ZeClQeRtK1@localhost.localdomain>
In-Reply-To: <1815496.OexNakQ7IY@localhost.localdomain>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com> <15825589.4VbMHeJK9p@localhost.localdomain> <1815496.OexNakQ7IY@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 3:38:03 AM CEST Fabio M. De Francesco wrote:
> I think that I've inadvertently switched the order by which usb_control_msg_send()
> and memcpy() are called. I'm very sorry for not doing my tests, but (as I had said 
> before) at the moment I don't have my device with me.

No, I did not switch them. There must be something else... 
Sorry for the noise.

Fabio



