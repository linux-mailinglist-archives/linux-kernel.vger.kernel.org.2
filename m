Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73D835E81C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348314AbhDMVSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhDMVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:18:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0997AC061574;
        Tue, 13 Apr 2021 14:18:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A7A8C2CD;
        Tue, 13 Apr 2021 21:18:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A7A8C2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618348709; bh=z35Gr30/0cJsmDEniTTwF782cakMcAN/LvWAlDM+tfk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RFn44QlSTH2lzQyLZGDXoz9oqxDu/dtwN9OFrQ8HmEeZ49fDcjI4Aa7sGLL9k/FTm
         zCsN7CnDQMgwh32IQ6YeFtqc5ex3ZnqLK/U0x6hyiCdG2+vGdcxYTRGd1U3X7YCRMe
         /WStDatbKNp5l8WFOSTIUeiJUtUWkZJetBB2plSwuhEJ0GrY0Ib27ZGBZgNpLDKZdg
         e8pIAS5mVrRyYhaS5JxjBw9LfoeJJIdLAs9Z6g0uxPknUt4HvhBiKbE7vlyeAi7pqR
         /94/cqBVRffQZxPGd7U/j6kjmijAsWnCrbC7TnCle4mDCqB3SZHCgm+Vs4aFfMXmE7
         g+1cN52oc9SGg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Fox Chen <foxhlchen@gmail.com>, neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, vegard.nossum@oracle.com,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 00/12] docs: path-lookup: Update pathlookup docs
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
Date:   Tue, 13 Apr 2021 15:18:29 -0600
Message-ID: <87zgy1rihm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fox Chen <foxhlchen@gmail.com> writes:

> The Path lookup is a very complex subject in VFS. The path-lookup
> document provides a very detailed guidance to help people understand
> how path lookup works in the kernel. This document was originally
> written based on three lwn articles five years ago. As times goes by,
> some of the content is outdated. This patchset is intended to update
> the document to make it more relevant to current codebase.

Neil, have you had a chance to take a look at these?  I'm reluctant to
apply them without your ack...

Thanks,

jon
