Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09D234D551
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC2Qnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:43:42 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36817 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhC2QnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:43:11 -0400
Received: by mail-ot1-f51.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso12880345otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8kolWYtJW37qJe2Kql1VI2PyddDp+zguMbPA91Z9Us=;
        b=YmYxeWvYb+XkZo0HRvh1UU8FOR92ZnWCRnb9iDu/hEQAW4nV34xxH6PKwgl5gbnY/D
         TvofuqW2ocaZMat7FnZIKNzMQzKL/qDKVw16CwwxY9TnMN2dJEKDzmAA7CrPToNnv+AA
         PYP4DTsM/tccFVzDEs7GPxPnPGc0dRzuTQ5eJDFmhw43gd7VvTdXZH49qBG93b/BxeoT
         c+0lhxCw358oIzvsJxxsuxKMf5uoS8BUMsSowyVAyDXQmB3PIOf9YyMAeRbk56fce3qD
         aFxs36cySmhUeDJFPhxFTec9c+muPMwDj8JbhafWuhEbLH+MtK6i9a6b+ic5byvF4Px3
         3kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=g8kolWYtJW37qJe2Kql1VI2PyddDp+zguMbPA91Z9Us=;
        b=hFD5cQg2lC7gCYyL/LaOKEa/zNLfGgene3eJbIpbpiFy565r21Ko2R+U9OSCUve8vW
         GlSd8qnAr4JRnpBVAq6ryibalSBhETR2N0AyXbNilFHFHOer6WoCapWC56ZNFq6lctJ3
         Ecvu/CyHjUMz6O3pqt/3+ueFS7NHXwnkC7ALvEmdPDcmoZIoZsyCXUHT4CPZOCaW6XYi
         EWM0a3/gOjBt4wj5/qex3t2yTdTJqKLfEeZ1QODX2iUiVTaBmBcrG3NyxFk4brO+Dp4s
         1sD4z+z9Wz4UdH82193qyQGYaDUOfXWwqHVE4Ya2U+3LF0/mXmRJ3Yr3b2TYLNR/wS1F
         8/9g==
X-Gm-Message-State: AOAM532EQjyc2igm2eqcbBGuflZ4gWHr25221CitDvlIBnKPHc29ZsHg
        ghSMsXjPBTB/5VEf6QXSBgkm5tH03ZAzfbkj
X-Google-Smtp-Source: ABdhPJwptw6MsDBKYxmuoKEkBBpZc8vdD8jwkuFIcX9GOVCs2axBhcFXQ7l96Pw51OJLZjHdnFg+sQ==
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr22887174otf.162.1617036115301;
        Mon, 29 Mar 2021 09:41:55 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id e34sm4480758ote.70.2021.03.29.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:41:54 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drivers: pinctrl: qcom: fix Kconfig dependency on GPIOLIB
Date:   Mon, 29 Mar 2021 12:41:50 -0400
Message-ID: <12736456.GqETC5XQ6s@ubuntu-mate-laptop>
In-Reply-To: <CACRpkda2Jbm3DmOhxFyyxDZRrUk01TtPbD+OOG=U7o2mnxEB8A@mail.gmail.com>
References: <20210225083306.25792-1-julianbraha@gmail.com> <CACRpkda2Jbm3DmOhxFyyxDZRrUk01TtPbD+OOG=U7o2mnxEB8A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 2, 2021 9:46:04 AM EDT you wrote:
> On Thu, Feb 25, 2021 at 9:33 AM Julian Braha <julianbraha@gmail.com> wrote:
> 
> > When PINCTRL_MSM is enabled, and GPIOLIB is disabled,
> > Kbuild gives the following warning:
> >
> > WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
> >   Depends on [n]: GPIOLIB [=n]
> >   Selected by [y]:
> >   - PINCTRL_MSM [=y] && PINCTRL [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
> >
> > This is because PINCTRL_MSM selects GPIOLIB_IRQCHIP,
> > without selecting or depending on GPIOLIB, despite
> > GPIOLIB_IRQCHIP depending on GPIOLIB. Having PINCTRL_MSM
> > select GPIOLIB will cause a recursive dependency error.
> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> 
> Does it work to just:
> 
> select GPIOLIB
> 
> instead?
> 
> The driver needs the library so...
> 
> Yours,
> Linus Walleij
> 

Hi Linus,

Looks like I confused this patch with another one when 
I responded last time. This config option cannot select 
GPIOLIB, because it will cause a recursive dependency 
error.

Any other ideas?

- Julian Braha



