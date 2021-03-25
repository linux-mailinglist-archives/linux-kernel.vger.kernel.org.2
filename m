Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24919349A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCYTn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:43:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:48662 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhCYTnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:43:18 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0BD30381;
        Thu, 25 Mar 2021 19:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0BD30381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616701398; bh=5hHvYfGKy00AO1jp6nvrSOoBWs+WfPCTQJFYb9ajUMY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AZ6wQpr9Az2pkrzhzBjOs1mgUTExSx3HJf5/x59h2NFBBsAU6UnvT390tVI5Yxx0Q
         sZP3k96/PqEI3Fh9ZeRoRbjp7ytI8dZvSYRE8ihOp5bDOodp78a1NLzjS8i4QEyvq9
         sGN2aW3Qz+kUK++uENTgFOGfQIYbO2Q7FOEb2v6WH+24DTckg1xfnCavhdrhw7oBr6
         lWzCHemq6Xhyb3lLWl3lz76K4Qz62J9avgdIOYmcLSYCkFk2PeVqrwEqWFo4og2G2Y
         wEfavm0VGpjUnIUsSVGWYABLOLknwjSxBPkFE57w2hGGOD/BmG5g45CVEqnmT87h12
         k/8eVsQJhM+Mg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] docs: reporting-issues: streamline process and
 solve a FIXME
In-Reply-To: <4bc573bf-3dc1-fb6b-e6d7-d51993725c29@leemhuis.info>
References: <cover.1616181657.git.linux@leemhuis.info>
 <c8770353-3d0d-17af-115a-efa4a31fd97b@leemhuis.info>
 <87y2ebysy8.fsf@meer.lwn.net>
 <4bc573bf-3dc1-fb6b-e6d7-d51993725c29@leemhuis.info>
Date:   Thu, 25 Mar 2021 13:43:17 -0600
Message-ID: <87v99fxbmy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> BTW, I wondered it it would make sense to add a entry to the MAINTAINERS
> file for the text so I can keep and eye on things and help with fine
> tuning. Let me known if you think that idea is overblown, otherwise I'll
> likely add one with the patch that I'll send sooner or later to remove
> the WIP box near the top.

A MAINTAINERS entry makes sense for a document like that; I think it's a
fine idea to add yourself.

Thanks,

jon
