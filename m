Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C6F3B5DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhF1MNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhF1MNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:13:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C795C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:10:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso13581751wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/s5ntRR1JmxnVmTebmtMvo/S0ha2iJsjhTLPq9iWUNo=;
        b=r8DcmgKnJzDsSe9H9XdHRMx+qFTw3ab7ZUGEi94m8rfq2F5rg2c3b66zKeWc47rsv+
         JXd54tjxiqLkS9ohZddHT2jh4w8bexyyZygC3N5k/EWMhLA3bafolhAO3nook56HshOO
         Yi1knHs/uDdKJCblnujaNy+A2FKiAU2HOp4u8NJyR73sYUdOkgof9wm4kI52ASzszIMq
         BgRNtuxIqpkS/WQ2/+LImWHrNB1AYq0nmfPmUZZSi2GH9XUdpJcoEEtzy8YIlZn1uZ3V
         22oNnxICMAA/HAbsCgfU7gVpvob6AebRLP5qib+NOaraQ3V8o5fgcmrzPGGj8ThS2da4
         4X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/s5ntRR1JmxnVmTebmtMvo/S0ha2iJsjhTLPq9iWUNo=;
        b=rr/jGi4ZHlusKyu9b8GHzBV9xWA/rgEtCcUos1MTU8XvfQUs+Gr4xbywdn3wet15NN
         fMYarulP4Ge5C7JmiO7y+fUGaJkCc5io90QtmVuDEiHVzq9FT6+q8FxkBF1C9wbuzqC/
         ffJWqgYL4Uzd5mdHEYiny9krWD1s91QvgTSTl1NJUJg/tnW0MCX1KzLdbzGOsVlj2de8
         f/xNTBZRv2QGzJm1ITiCz+KDiWnqXWyKsOnS0j9YnQ1j+YIer8oQz0k3Yu+oOIjijojP
         mUGzHraHZF33Wapdtq8/9w2TWY+eNs6m1ycGIRoFLZ9anor5Ak3pi36S1/IuQa+HLr4v
         4rVg==
X-Gm-Message-State: AOAM531DrDkS8CFdJSDNAFvNOmNr20poRsSjrNJVvjS/hjNi6Tm0ENx+
        im28wYtX33hREfP/S1cBK/g=
X-Google-Smtp-Source: ABdhPJw0b+zEVGJoy+JpR4p2RvtMfiKkQ7V22N6GI37OQ3+H+aRCKqKL/+Qe9aHWKx8qF5tmN77JFg==
X-Received: by 2002:a05:600c:2cb5:: with SMTP id h21mr1646938wmc.91.1624882240885;
        Mon, 28 Jun 2021 05:10:40 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id c133sm19076433wmf.0.2021.06.28.05.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 05:10:40 -0700 (PDT)
Subject: Re: [RFC] strcpys(): New function for copying strings safely
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        glibc <libc-alpha@sourceware.org>
Cc:     "tech@openbsd.org" <tech@openbsd.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        drepper@gmail.com
References: <755875ec-baae-6cab-52a8-3c9530db1ce6@gmail.com>
 <38428d5e-ead2-bf18-e198-cecd4caeb3e7@gmail.com>
 <f5bfab0dce604736b6a563a4f9f7ce43@AcuMS.aculab.com>
 <52e57bd5-0d04-4b4f-978a-8c1dbc08115c@gmail.com>
 <d27912e6-f090-68af-295d-d40b00c1b0a7@gmail.com>
Message-ID: <6ea2efaf-7898-9723-54e7-2cd59702f854@gmail.com>
Date:   Mon, 28 Jun 2021 14:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d27912e6-f090-68af-295d-d40b00c1b0a7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 2:00 PM, Alejandro Colomar (man-pages) wrote:
> l = strscat(n - l, dest + l, src2);

Hmm, that's a bug; I wrote it too fast.

Either

l += strscpy(n - l, dest + l, src2);

or

l = strscat(n - l, dest, src2);

should be used instead.

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
