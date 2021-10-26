Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DD43BB50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhJZUAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbhJZUAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:00:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D9C061570;
        Tue, 26 Oct 2021 12:58:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so1209434lfu.5;
        Tue, 26 Oct 2021 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2EUbiSBFqMAbwlq+Hh6bZmWi5bhxCtnpI1o6+QMB2g=;
        b=SoHipItjHdtWBcxrwaOJGDTQDqdCu4ryplWxTF37sBQ1eLniffJQZZh80tiRvrhWJw
         qzhJC2dZwIRHZcVcW5I6WZOC0H5nG3gHUSB0WZSvqrau4BY2IqXUbrwyHsTmzkXlPBxA
         rbeM4pBik8HbrF9E2CYIjhW2SLcEb5F1Qt2OUguC6UxUtoF6BaA7Td41aCHapJzUHDfQ
         PtpX2JPiIczvqi5lEO69txh+KLUsXX/MjyU+cnlYilh/gDG3XdALHzVdA7SuzPp0rhRt
         B7PouoYeKTm5SeHeeaXJaOg+7MaYcXlQMKgpnE2o2gzmIkwTstXWvo3GcfHchAiro5cQ
         MWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2EUbiSBFqMAbwlq+Hh6bZmWi5bhxCtnpI1o6+QMB2g=;
        b=OD7sza7vVRaQimbIS0rZ7TTEnRPEl3ID6tCvNqO6D5ZEcGFgjc4MslsOP0b9w0Zvcd
         XyjAa55HpDKt6zwz7EQJgxpfzaowbZfrNUB8RheEZKiQWRJHKnYMdc8FUYdHvuvGFE+8
         gwUufP8/9ZO7p1b2mjn0hF2FGsYUszqn1R9OOr6heGqFPLzYdz49OO4wW34MKnYRqNS2
         H/OEvvXBroct5HIfoabjo/+uXQXjt3JzuAjSAZa77SsTT2d+jrbmov+Ls4npCgbdRdHr
         ZTv6T8+thIOpaP0X0fTmC8SwjvOqu9ISLzo9NGgbxGZ5tQ+LHIsZ6ECxyMPEZTFXmFs1
         h9JA==
X-Gm-Message-State: AOAM532wBlpC19nsDijb+ZHhk1sx5vmv4rVj6YdcMKvxrpZWULH/SWwy
        DdWpXOVrTTWLukihr7NmvYoFXeDohUtP6w==
X-Google-Smtp-Source: ABdhPJzAIHsmf6jhU+O5aBG2Yjds5qCqmoR//7ADUCzjefCud9HvzJygMhzcWwpYBJ0ouhiOtkmwHA==
X-Received: by 2002:a05:6512:3f04:: with SMTP id y4mr24721401lfa.180.1635278294066;
        Tue, 26 Oct 2021 12:58:14 -0700 (PDT)
Received: from penguin.lxd ([94.179.4.108])
        by smtp.gmail.com with ESMTPSA id w26sm2436759ljh.18.2021.10.26.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:58:13 -0700 (PDT)
Date:   Tue, 26 Oct 2021 22:58:05 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     eugene.shalygin@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <20211026225805.1504a9f9@penguin.lxd>
In-Reply-To: <YXcKLvRu3gRm3zUF@smile.fi.intel.com>
References: <20211022200032.23267-1-pauk.denis@gmail.com>
        <20211022200032.23267-2-pauk.denis@gmail.com>
        <YXcDcXrUo4a/KAsT@smile.fi.intel.com>
        <YXcHYvleoOr6sqMK@smile.fi.intel.com>
        <YXcKLvRu3gRm3zUF@smile.fi.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you, currently code has returned N/A by some reason. I will search
place of regression.

On Mon, 25 Oct 2021 22:49:02 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
...
> 
> Okay, here a few additional fixes (make them symmetrical and hope that
> it will compile now):
> 
...

Best regards,
    Denis.
