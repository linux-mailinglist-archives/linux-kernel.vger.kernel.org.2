Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31D3EC201
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbhHNKWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhHNKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:22:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C9AC0617AF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:20:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h9so22939937ejs.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJMFfB5qivF98UTpPlObntAxqLBo93oWecY40iYHQHQ=;
        b=Gzw5YbwVsQHnzjACSEIRMx6WiZ9JQ1tLFs6p+F14Bq9SGXdBe9UoHQNbW2UU4iQYPw
         CSvVefOwssotA9XVkyvJW8KhDChTCS+U3EGbYVcw2OynQvBtVNK/7BgCqjJKC7aUJszp
         z+K1P6ZBf0Ls0lTYZbrLxi8drt8PWEuNAVeEKCQhfHoM7NVAVRfhlVD4czi8qz42kxzX
         x4yFHtmtxkXZMKhmTHQc72IWghlgRBmgA/620fpypC2GTkfGOnhbc4mjbov7tAMtnzJe
         KLvu7I2CACqz3C5dsFy6xvgDffpBEbyaCrAXza7SbGP+3w3omm3DRDGEqPscDeYZWF/5
         Rtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJMFfB5qivF98UTpPlObntAxqLBo93oWecY40iYHQHQ=;
        b=gMkCk0GmtxRJR04s92CqoT22trPoBXhVKNKubQfP7jdmzlphOP72PZU20CnaeGFhXm
         RLWKowUPRqLP/GDZR7Cg2qtP5ctEgciRINWmxAikVPRybOxT3Y7i9pPyc7cL4HXx8RDT
         z7Xi1k2JDp+fUu4lYC7vZyptLj71fRanUB1ZdEO0j3Td5cyeEBwGzUq43XVCEGjdAshz
         UpUXvxIMevX1RIVwNN1/ISv22wiAy/+KG4v/I1H+yc1IRYru4w1/Ge6raCvKOOIQBtLr
         VWlqkyffdZCwdKkFmYtYXg+oHcvdzhP4twsF4hJKE3wdjTrVNe52WwSoodlv6pFP3FKS
         ohWg==
X-Gm-Message-State: AOAM530fSk5ane3EPCTuTI7oF5ThZ5Gz7RAIqopRhkfW/VxfBhfX90cc
        p+9za8nGb4AVPQYfdlg6zKk=
X-Google-Smtp-Source: ABdhPJxsPrFDT3Au2VT49jXUIfgu/4WrpFPyKWsoc1HpcaMwn2FVwhDcRIOXEoEM9cX2V5EX0Q0AFw==
X-Received: by 2002:a17:906:27c2:: with SMTP id k2mr6836723ejc.83.1628936435225;
        Sat, 14 Aug 2021 03:20:35 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id n26sm2057213eds.63.2021.08.14.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 03:20:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove ODM_GetRightChnlPlaceforIQK()
Date:   Sat, 14 Aug 2021 12:20:33 +0200
Message-ID: <3475843.yqa22ZEQPp@localhost.localdomain>
In-Reply-To: <20210814073920.3551-1-straube.linux@gmail.com>
References: <20210814073920.3551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 14, 2021 9:39:20 AM CEST Michael Straube wrote:
> Function ODM_GetRightChnlPlaceforIQK() returns always zero for
> channels <= 14. The driver is for chips that do not support 5 GHz,
> so remove the function and replace the usage of its return value
> with zero.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

There appears to be some superfluous code left for the 5GHz band.
Nice removal, so ...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio



