Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D5438099
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhJVXYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:24:00 -0400
Received: from ixit.cz ([94.230.151.217]:35084 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhJVXX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:23:59 -0400
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BD5DF20064;
        Sat, 23 Oct 2021 01:21:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634944900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pg6Vln71vk+dI9FRgFUxA0oEAjU1lFBgq6TXV8KkxhY=;
        b=agxz0T67UzN9FYqeiy7ueay1Aa5x3Zziw/Dn7wHFWfbQFZ650chJ/5wJoai9FH/kxRU3mq
        7cywkXGDtJsKf/9BvIskiKvzSvNN/VVmm0AB8fieZBwjDxxYt5RngC0e1S1gLTR6o/Eze1
        lvM+s4rK31qfWi6w/ZxFfhXN2iiUNSo=
Date:   Sat, 23 Oct 2021 01:21:34 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] WIP: dt-bindings: arm: firmware: tlm,trusted-foundations:
 Convert txt bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Warren <swarren@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
Message-Id: <YJJE1R.GPJY7VJ2F2SU2@ixit.cz>
In-Reply-To: <CAL_JsqKD-3-VkFT5fAKrD0jFWWmBFTQHWQKSv4JrfZ515GVP_Q@mail.gmail.com>
References: <20211009104518.45596-1-david@ixit.cz>
        <YW86yrhJBTunU121@robh.at.kernel.org> <GXW81R.AUXV3AJ9VUDL@ixit.cz>
        <CAL_JsqKD-3-VkFT5fAKrD0jFWWmBFTQHWQKSv4JrfZ515GVP_Q@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

done, resent.
David

On Fri, Oct 22 2021 at 09:16:26 -0500, Rob Herring <robh@kernel.org> 
wrote:
> On Tue, Oct 19, 2021 at 5:26 PM David Heidelberg <david@ixit.cz> 
> wrote:
>> 
>> 
>> 
>> 
>>  On Tue, Oct 19 2021 at 16:38:18 -0500, Rob Herring <robh@kernel.org>
>>  wrote:
>>  > On Sat, Oct 09, 2021 at 12:45:18PM +0200, David Heidelberg wrote:
>>  >>  Convert Trusted Foundation binding to the YAML syntax.
>>  >
>>  > Looks fine. Why WIP?
>>  >
>> 
>>  Can you drop the WIP prefix I forgot or should I resend?
> 
> Please resend.
> 
> Rob


