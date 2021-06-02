Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74563397DD3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFBBCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:02:38 -0400
Received: from befuddled.reisers.ca ([206.248.184.127]:57816 "EHLO
        befuddled.reisers.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFBBCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:02:35 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2021 21:02:35 EDT
Received: by befuddled.reisers.ca (Postfix, from userid 65534)
        id 7990938258F; Tue,  1 Jun 2021 20:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=reisers.ca;
        s=befuddled; t=1622595252;
        bh=2Yogg4RAw/HBYScQC/cly8YEOhVm8TXpDT/L5tO8V4I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=isR6T2AOk/BRhuuGe6hD7SYQnoMsF5rsZfJKaYGKFkH9Nh/NXDi6j0i86ZyVM+TRu
         ct2p63DssBRZtVdjXm+w0epVV93RGkJ1lls9TPm+OEEDItLrKrQRpSIKovliK6TA2l
         cqN7OKzj053lOkTv91OoVXMHXUAh32/K9C4UfMSo=
Received: from localhost (localhost [IPv6:::1])
        by befuddled.reisers.ca (Postfix) with ESMTPS id DB92F380A89;
        Tue,  1 Jun 2021 20:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=reisers.ca;
        s=befuddled; t=1622595250;
        bh=2Yogg4RAw/HBYScQC/cly8YEOhVm8TXpDT/L5tO8V4I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WhFUiIjzCGPyp287A+eCmx9ytTZjPr46LrOY2fAxbDeYA2RtFLEo+R5JVFnuhRkWN
         j0JLsxyyDMM83Uq2dq4adCATKHnyw4lrz5TFg4EIf40XIIVkg+DYABlbz2jwIbmrww
         CX5BU8U9IMkTYUaJUEkNlNYYNuz9hZg9bFcr0DEY=
Date:   Tue, 1 Jun 2021 20:54:10 -0400 (EDT)
From:   Kirk Reiser <kirk@reisers.ca>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
cc:     speakup@linux-speakup.org, Jonathan Corbet <corbet@lwn.net>,
        Christopher Brannon <chris@the-brannons.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Steve Holmes <steve.holmes88@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
In-Reply-To: <20210601224854.iug2arwes64k7fxr@begin>
Message-ID: <afc570ec-dfe1-2a37-6fd3-aeaefece4aa6@reisers.ca>
References: <20210531215737.8431-1-igormtorrente@gmail.com> <875yyxbenm.fsf@meer.lwn.net> <20210601220643.uzep2ju2zlcmpa57@begin> <874keh9qk9.fsf@meer.lwn.net> <20210601223743.carif4gkzcz5jo7j@begin> <20210601224452.sqblwctwiu47xgqg@begin>
 <20210601224554.6kc5syoy2tscisiv@begin> <20210601224854.iug2arwes64k7fxr@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gene's current address is gene@cllinsnet.net

   Kirk

On Wed, 2 Jun 2021, Samuel Thibault wrote:

> Samuel Thibault wrote:
>>> - The initial import of the file (bddef0d280cd) wears only the Gene
>>>   Collins copyright notice.
>>
>> I'm here fixing the mail for Chris and Gene with an up-to-date email
>> address, I also bounced them my previous mail.
>
> Mmm, no, acollins@icsmail.net is not working either. Does anybody on the
> speakup mailing list know an up-to-date mail address for Gene?
>
> Samuel
>
