Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B4398927
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhFBMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhFBMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:17:26 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D475C06175F;
        Wed,  2 Jun 2021 05:15:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so1151927otu.6;
        Wed, 02 Jun 2021 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vHaetPkPYRHDvu2+wyaKBx30j/WfRHRRi21yYZroKbc=;
        b=UiBPdb5Xpo/NhTFb0DyMRgveRdOFxhrIzHEzapfrt250dlq8eGJ8gGdTw/rf1/whEI
         oCKjogFCiQzzF7H6JKQlvuWnZD2VVQZzkAPI8ZzBOGAnpMelWIwdK3Lw0hS1+iC6SZyg
         C7r3uIClhHdySn5LyY6Z8p5jMm6P+tU8XRRP3hZMPeOQwGDrT0SclWbvQuW1RA7GS1B9
         cTc3YKLT+AC3LyVzdBMS3aj+nae9MKUA4wFQpMFR9xjWGJEnEMragY50FwdCV1/w9Lbr
         4fwACAmfQp1aPo6EnAz+9OnjkOwsVnYf9G/UMcV+4TYHu/ZrUQ6whYU60CEHkl/EwuWL
         ncvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vHaetPkPYRHDvu2+wyaKBx30j/WfRHRRi21yYZroKbc=;
        b=cvZVCbGM7DrQOtWAjIbZ+PTcfGOcFxYCOaBslZR1q/H1heq13l+soVjvQYow8SaC9z
         I9GxmvQMtmS2BsUAjzH9t36nL8gYoJBG8tvL4IpNDoK7oFejHHSUkNQdRm8T86b1n6J8
         ORadZuAuBctl+piP+t2vOO0FfwL/PRxyY5toEmErNaUDWBnVF+NiSvSqIJWT3prPylp7
         vEBIAYaQ94TZ3rnZt+krfSJ2daL4ReBCdIq8hkqUl+/mxELKU/J23da/bzx2zT7bgjb4
         JTtoK2mN5v+uuvVdjGJbvWCUBZKtsFVAryfHYQtIsJSvECytzO+WNBL/MTE1EkXGLI5x
         BNwg==
X-Gm-Message-State: AOAM53176YeBfixvLH9gMQ7ZuEFGIRjEeoCDrtkFWAcSiQOL4sqbnIqZ
        EiIJQVyAHn7Cps+zxMcQjBpDIBZPS9I=
X-Google-Smtp-Source: ABdhPJwY7sDLsrEheHpyZSRTmc6IRc04vspGjL1pK0T8w0U4yKh0sAdUA6NPR5YZJTXrcCQQnfutww==
X-Received: by 2002:a05:6830:15c2:: with SMTP id j2mr24647349otr.367.1622636141573;
        Wed, 02 Jun 2021 05:15:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11sm132341otk.78.2021.06.02.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:15:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 05:15:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Nilsson <daniel.nilsson@flex.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] hwmon: (pmbus/pim4328) Add support for reading
 direct mode coefficients
Message-ID: <20210602121539.GC2901466@roeck-us.net>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
 <20210601164320.2907-3-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601164320.2907-3-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:43:17PM +0200, Erik Rosen wrote:
> Add support for reading and decoding direct format coefficients to
> the PMBus core driver. If the new flag PMBUS_USE_COEFFICIENTS_CMD
> is set, the driver will use the COEFFICIENTS register together with
> the information in the pmbus_sensor_attr structs to initialize
> relevant coefficients for the direct mode format.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
