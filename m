Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA63A5AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhFMW5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhFMW5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:57:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DA0C061574;
        Sun, 13 Jun 2021 15:55:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 18F684B7;
        Sun, 13 Jun 2021 22:55:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 18F684B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623624905; bh=I+Vq6Gwozb8Nq+jUqrbfEiAsOmNmEYra8HTSF0qeudk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mJ1a/9wKinIKrIyMzV7MsIc4JxBpnqQ1ysRaBMzvRWUz7+I+s670ENgAkW2PSCdpt
         d3hqc03jc6pzVmnshrdrM4Iyv+1RpFWGqDykNLHtUgTrxbSf7xtCWvcWgrZ5QBOJMS
         Z5Sun+6wqDUJ2vaeXADmdt228x+d+BPeqqs1iZy3Gkhf20MIYPNuXUCRjiAPbCD2sd
         iJtm4IE+Qv3KtndjkRY+yh2S2g/6MIkA8oY6ybpj2pxmR9vnWI5EDgCtfI7eS45bgO
         cvQ3oYRrfu6Rzk1y2Ol9SjkGHP3HOeIhZiZI2K2J3Hnn/G+d8aX4cKV46thBTvgYyb
         fATySirIp0OtQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: add traditional Chinese translation for kernel
 Documentation
In-Reply-To: <4ecfaca0-801b-1827-2d6a-13690e016957@email.cn>
References: <20210607132414.44601-1-src.res@email.cn>
 <4ecfaca0-801b-1827-2d6a-13690e016957@email.cn>
Date:   Sun, 13 Jun 2021 16:55:04 -0600
Message-ID: <87wnqxbcjb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> writes:

> =E5=9C=A8 2021/6/7 =E4=B8=8B=E5=8D=889:24, Hu Haowen =E5=86=99=E9=81=93:
>> Add traditional Chinese translation (zh_TW) for the Linux Kernel
>> documentation with a series of translated files.
>
>
> Dear Corbet,
>
>
> Is this patch applied? I have another amount of changes on this, so
> please handle it as soon as possible.

I have been away from the keyboard for the last week, and haven't had a
chance to look at it yet.  That will happen soon.  Meanwhile, please be
patient; it has not yet even been a week since you posted this work.

Taking a quick look, there are a couple of things you can do:

 - We have a Chinese translation, now you are creating a different one.
   Please explain why that is needed?

 - Please find somebody who can review this work; that is not something
   that I can do.

Thanks,

jon
