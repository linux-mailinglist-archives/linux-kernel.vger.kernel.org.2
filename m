Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721DF34EBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC3PRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhC3PRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:17:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFCC061762;
        Tue, 30 Mar 2021 08:17:15 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lRG7F-0000L0-Es; Tue, 30 Mar 2021 17:17:13 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1617113469.git.linux@leemhuis.info>
 <762ccd7735315d2fdaa79612fccc1f474881118b.1617113469.git.linux@leemhuis.info>
Subject: Re: [PATCH v1 3/4] docs: reporting-issues.rst: reshuffle and improve
 TLDR
Message-ID: <457e7831-bb5e-d42e-55f5-9292a524bd4e@leemhuis.info>
Date:   Tue, 30 Mar 2021 17:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <762ccd7735315d2fdaa79612fccc1f474881118b.1617113469.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617117438;047b062c;
X-HE-SMSGID: 1lRG7F-0000L0-Es
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh, sent this just one hour ago and I already found the first problem:

On 30.03.21 16:13, Thorsten Leemhuis wrote:
> Make the TLDR a bit shorter while improving it at the same time by going
> straight to the aspects readers are more interested it. The change makes
> the process especially more straight-forward for people that hit a
> regression in a stable or longterm kernel. Due to the changes the TLDR
> now also matches the step by step guide better.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> 
>[...]
> +Are you facing a regression with vanilla kernels from the same stable or
> +longterm series? One still supported? Then search the `LKML
> +<https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
> +<https://lore.kernel.org/stable/>_` 

FWIW, this needs a

 s!stable/>_`!stable/>`_!

Sorry, this slipped through. :-/ Ciao, Thorsten
