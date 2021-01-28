Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C88308220
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 00:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhA1Xzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 18:55:33 -0500
Received: from ms.lwn.net ([45.79.88.28]:51954 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhA1Xz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:55:29 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C130D2B8;
        Thu, 28 Jan 2021 23:54:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C130D2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611878089; bh=YdD+k8vJN24eZfQuSsHdwnb9+XXDsBI/7xyammat07o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4c4WhtX4sz2gyAotY2Iyml6l/BKOQGzF6VJm9hPhTO6Ocf5YpZ4MP7DO8byYRN99
         ULQg7ab5mgIAIO5X3UzpIq7wsHzWWF0ayoOEg/0z0XWSMGrDszNrCTgbi/orvIKFGa
         rTJir9ItNpCMhUXsqCpnMo3j2EtokSJm6Vs98QwuLXXjapjskVejUCITy+UaRUDCJO
         TIAtO42LRdaLAYihax4w1r9/ptzYEvpX00AxtINSr+v6jMxXhb8d7iokY3NMQ5ydHD
         lD4mxhAxcj9w0WjF3o6NA82hrj19eXG5Znc2VnCkKyx1oAzCKUD3qdbqsOd8R0axKO
         8BpVxNu+em3bA==
Date:   Thu, 28 Jan 2021 16:54:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     devel@lists.elisa.tech,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        =?UTF-8?B?QmHFn2Fr?= Erdamar <basakerdamar@gmail.com>
Subject: Re: Small student project idea on appropriate integration trees in
 MAINTAINERS
Message-ID: <20210128165447.3da0d98e@lwn.net>
In-Reply-To: <CAKXUXMyRAer=0S9pxiRs2iF3pdkU8zW=JZw2a+nJJ30iPLPhCA@mail.gmail.com>
References: <CAKXUXMyRAer=0S9pxiRs2iF3pdkU8zW=JZw2a+nJJ30iPLPhCA@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 09:22:24 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> In this project, we can make use of:
> 
> - gitdm [git://git.lwn.net/gitdm.git]: gitdm includes some scripts to
> parse MAINTAINERS and obtain the integration tree patch of a commit.

Look also at the 'treeplot' tool there, which determines which tree(s)
each patch went through and makes pretty (OK, not hugely pretty) pictures
from the result.

I suspect you'll find that the tree information is mostly correct.
Developers need to know that to be able to base their patches properly; an
incorrect entry would lead to a certain amount of maintainer misery.

Thanks,

jon
