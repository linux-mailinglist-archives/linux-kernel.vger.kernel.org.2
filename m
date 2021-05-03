Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58B371E27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhECRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbhECRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:10:58 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188ACC061345;
        Mon,  3 May 2021 10:10:03 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso5730374otm.4;
        Mon, 03 May 2021 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e/7LmIWoaS1F90Lr+XFUo04J8qeVgO0peqhjoMY4xTw=;
        b=dd89wsext3/XE5e2ErNWdIkMH6JH8Dipwb1+g47Q9Hvrmq6+Jd/OhueCOjuEmBx1mQ
         +ZzlUzwlfEKWDScKqbgKlWckTePVkOkmt51xyVtTN8uAzLEnJi7V+4zidGrUDIrHmbSS
         zqJKSTnrpnMfPYzg5B7vRmhW2QUkS6Jkt3DcBaHdTZy+UJlslqCHcAXDFRayxN3tYZAC
         MOnfjKfBwUHY3Js4fKv7a/hIkqnFYkmUi4pjXXfezZOyTXU2DQCwhQAm2VeWVZ2GsnjC
         /bZ/t4FxvWVyEc5lMK0a/oxMd4AJ1iQjc8omgNA3eLpJ+q/jLaS4jzCgm+ab927s36D1
         ye7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/7LmIWoaS1F90Lr+XFUo04J8qeVgO0peqhjoMY4xTw=;
        b=itmxPckvhzmoeCIpDCBS7eXNOyLjYZ2ryKlAtJGj63pzk3cYNk4Er9QrfZcH1jw3yf
         9l6ZnsezntR/bMoy4oAge8pRYAmEuAos93N4YOKLwGs4XO84Bu65kmCjKNaXaLoatFIt
         ++WP86ps5YEhE93ZbNlV/BP6l0/bi+129jK8V8nrZDSIf1vo/XjespJAC7O1eBZfkCEB
         ql7n3mXLj9VeRQ0SnxPcPohGXA3FUfzecpXcNIVKikZEooeu1xy9dyVZBsfI3hQBHtzZ
         THtwg+cFYGjxe8PT+IPYR8kl7LAfWsj1j0lIkkZsz8rIt+pnztKh2A9EnZnOy4H/NPmH
         IRDQ==
X-Gm-Message-State: AOAM533Mf9jzpVomm64JbW/ZiduBljtrkPkK3yKZrdsBKnS2ZegaTdpf
        i9tBI4UTJEbk9qvXKDibJ4ar0yDLpD0=
X-Google-Smtp-Source: ABdhPJw4ehm8vIOHmVQ8ufQY/s/WsYqZrkkGgJ9+pFuJfqXvEdmrIQbKg5sNthbmaR7tGjqurk+fjQ==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr598459otk.262.1620061802753;
        Mon, 03 May 2021 10:10:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 88sm97732otx.2.2021.05.03.10.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:10:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] Add ASRock HDD Saver support
To:     =?UTF-8?Q?Pawe=c5=82_Marciniak?= <sunwire@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a83f15e3-ac09-abf2-d8da-7b1ac86efc70@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8c2c6024-ae3e-2ab6-314a-6dd357bb428b@roeck-us.net>
Date:   Mon, 3 May 2021 10:10:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a83f15e3-ac09-abf2-d8da-7b1ac86efc70@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 8:58 AM, Pawe³ Marciniak wrote:
> Some of the asrock motherboards are equipped with hdd saver technology.
> It is implemented via a special power connector on the motherboard and a corresponding custom made power cable with two SATA power ports.
> The control is via the gpio10 pin of the nct6791d chip.
> When this technology is available the module creates the hddsaver_enable file.
> Reading the file returns the current status, while writing turns off or on the power of the SATA connectors.
> 
> Supported motheboards:
> ASRock Z97 Extreme4 - works 100% tested.
> ASRock Z97 Extreme6 - Based on boardview/schematic should works, not tested.
> Other ASRock motherboards supporting this technology - status unknown.
> 
> Signed-off-by: Pawe³ Marciniak <sunwire@gmail.com>

I don't see what this has to do with hardware monitoring.
I am not going to apply this patch. Feel free to submit
a platform driver to implement such functionality.

Guenter
