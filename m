Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D3938B891
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhETUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:47:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:34278 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhETUrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:47:09 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0572E307;
        Thu, 20 May 2021 20:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0572E307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621543547; bh=JuC7by8pKyIGHMXYDCfFRTmxtsigqmtpm8lM5fb+p8M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CbP2HhZCz+Et9uvPSgZxl3/PNPK23WYQipYI5hFaWF3P/pNPPj/Z9Eta6nh9DZdzx
         BBTWSYD74GkSaJJ2RQiKDutLNbUDwXRsmlodFo6E4x0TTKXjBVc1UJ3pjebgOv/sIf
         EQc3SiRfpOlgb6Bu4r7o95U3p5Htzfsb/FIVIJ5SnBOeBuKxVWj1p7SjH7uU68pECu
         2hvL7taUMAfJLW4JtKFGifxK2XfRM7Ti0Nl5hJFIKa0sJfHACWlc9M8WP4upYlSxz8
         T8MpTg9e8sOtqsrJqNVyTkOvaM6jMt++WewwLJaUdEol7ad3RL/i5O5Wh0R3XdWNIs
         P1mdBY6lvPCvQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] docs: Add more message type documentations for checkpatch
In-Reply-To: <CABJPP5D=Z6Uwr5hihB1yHjxcww=QO8Ju46m1eruRTuJkKWDXpw@mail.gmail.com>
References: <20210515132348.19082-1-dwaipayanray1@gmail.com>
 <87k0ntnoyq.fsf@meer.lwn.net>
 <CABJPP5D=Z6Uwr5hihB1yHjxcww=QO8Ju46m1eruRTuJkKWDXpw@mail.gmail.com>
Date:   Thu, 20 May 2021 14:45:46 -0600
Message-ID: <87y2c9m8w5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwaipayan Ray <dwaipayanray1@gmail.com> writes:

> (Adding Joe for comments)
>
>> We really shouldn't be linking to outside sites - even kernel.org - when
>> referring to the kernel docs themselves.  Just say
>> "Documentation/timers/timers-howto" and let the build system handle the
>> links.
>>
>> There's a lot of these in this file, alas...
>>
>> I've applied this patch since it makes things better overall, but I
>> would really like to see all those URLs go away if possible.
>>
>
> Thanks Jonathan.
>
> Yes it might make things better for the documentation, but again
> since we are using these descriptions in checkpatch's --verbose mode,
> we shall lose the ability to show the links there which I think is currently
> a good addition for the end user.
>
> And I don't think there will be a way to generate these links in checkpatch
> without sphinx's build system....

Ah, OK, I wasn't thinking about that aspect of things; that does change
the situation a bit.

It wouldn't be that hard to do an equivalent of the automarkup magic in
checkpatch to create the relevant links, but I'm not so set on this as
to try to require that.  The links can be as they are, sorry for the
noise.

Thanks,

jon
