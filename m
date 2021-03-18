Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E103405F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhCRMqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhCRMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:45:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:45:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u9so3726208ejj.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gc1bqkQYJ8DT/OOtW881nEoJaT0EwRcv98KUQi0MPYo=;
        b=JtJGeTs4WH0gaZt5/w+NaTjN5b1wxSTplEgrQoyvb2OWt8TeaEFcsvFmJFR1Iiu9ka
         HO5gjWlw+NB3r27yaipgp/J9J/jLzOLcL0I73wy6q+PR5OwcRCBCldvbZOLf6Ngs04u4
         qYn9rL//qls1mD6PALLCG4unNeMhZP05imL3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gc1bqkQYJ8DT/OOtW881nEoJaT0EwRcv98KUQi0MPYo=;
        b=b+7MJgoK0pNE+9snOWMzXmbwZm8b/6D9NEmry5DoGrWXH0sIHwe+HvRkWOqh16cxy/
         8S2XPjO7stSV4erjnH7OnFSgNJRWecYOA/9458X7SbZ+HaEGeHs4lXHHwLcqDRKC1VF/
         KWPuANslhBWjYaThbpsAoGP0aU+03NGdkZV1cJm/yhVLC9p8Zbji8kt8lt7/i0yQqpak
         43of1vvaP3s9oAKK6jKes+qaw0twqFOnisL56U/ENHYXqw7YmzECxFt9tWEUpwwhXsjt
         CizRfujetvL6j7YK1V97f1n/sMxYTzHDPQfkXqAJKs0wD1/q+pjRf1rWpJ5Dw+D9fPkL
         pc0w==
X-Gm-Message-State: AOAM530dT3FRQL1cEk0ks97JqWC0xqMiDpIESA7eZzL8S5ipXFVBCgnO
        l1Sb7Gh4E24xXD/zNgQJtuYxNznMwMR//w==
X-Google-Smtp-Source: ABdhPJx+vQWEJHn7WImfSyEfe9RK8Xw/Wf6R1UzUh1LFWsmgrwt/Ddr9xV7VRCY5W2CaGfVsS44q/Q==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr40965345ejc.301.1616071543003;
        Thu, 18 Mar 2021 05:45:43 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id d5sm1780936ejc.98.2021.03.18.05.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 05:45:42 -0700 (PDT)
Subject: Re: [PATCH] ARM: decompressor: remove unused global variable
 output_data
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210308142921.1287584-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a72fc587-695c-e397-03c7-5cdac5a99be2@rasmusvillemoes.dk>
Date:   Thu, 18 Mar 2021 13:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210308142921.1287584-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 15.29, Rasmus Villemoes wrote:
> output_data seems to have been write-only since the flush_window()
> callback was removed in commit e7db7b4270ed ("arm: add support for
> LZO-compressed kernels").

Ping.
