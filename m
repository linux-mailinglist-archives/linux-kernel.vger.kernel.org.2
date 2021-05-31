Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE4396A12
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhEaXbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 19:31:14 -0400
Received: from darkstar.slint.fr ([172.105.89.79]:51960 "EHLO
        darkstar.slint.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhEaXbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 19:31:13 -0400
Received: from ici.slint.fr (men75-h08-176-172-247-100.dsl.sta.abo.bbox.fr [176.172.247.100])
        by darkstar.slint.fr (Postfix) with ESMTPSA id B3044A3760;
        Tue,  1 Jun 2021 00:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=slint.fr; s=default;
        t=1622500152; bh=BekxmsRSTRpLEJ/qAfxxLSqn3iH8jwYzAGRtrRUwOwE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=O4sbFxs9nUOMOi1V2vnsRwYQiMVY/drRMiaS1Ggk5XrYzkRv2sMqtiR6ww7OuQYd8
         IPC9KpsV2V37axopQWFP3g2/cpSm17vOJ6nPCV14vLs7+kQrFRJxsIFKBVs2fyiHnU
         N5nSzFmQrYTBUiDdUYgyVv2e0NDWccFRaRADXjKb52s/IgLVtjAkyNuKEJE9toc+i1
         1ghGXkjfYUdmwZVsDCDhdryLgnToWARt1lofUtfFgn56YvLZUroJUkNwBfkl3EmxTz
         m2vwKVPZOPj1Hm2AgSyH+ATMUgug2GQgPY2QTnKgTADehBF9tnAxtoeqR5Siu8d4Mq
         YmHGMTQ7ERf7Q==
Subject: Re: docs: Convert the Speakup guide to rst
To:     Gregory Nowak <greg@gregn.net>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin> <20210531231515.GB8130@gregn.net>
From:   Didier Spaier <didier@slint.fr>
Message-ID: <45d7fd11-feab-5f3b-b102-6bd67f3113c5@slint.fr>
Date:   Tue, 1 Jun 2021 01:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210531231515.GB8130@gregn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2021 01:15, Gregory Nowak wrote:
> Another concern is that if the speakup guide is maintained in RST,
> that could dissuade others from keeping it updated who don't already
> know RST.

I only we could find someone to keep it updated...
