Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472CB44B97B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 00:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhKIXxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhKIXxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:53:46 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A9C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 15:50:59 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 5E262C009; Wed, 10 Nov 2021 00:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1636501856; bh=vmSFDaCPi8DnwE17dsxm2GHByi1ky6lumSc6dbJflws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TagJwnaomPmVJ6p9xRhYeOdCoU7GCaGz2bcDmptBBau7VcopO8QJ5PD/24QW9I2mt
         MSS+tuiu3fBVOQBrPWh4l7mD46Zx3p2sJxDAU9TuzQ9mPjxd0t2WHY2h7/ZDrqnzrD
         FcbpwhTDFR9MYFx8ijK2yJcjtA5Uc9GNLVXr8pK9sFMB7sfwdTrzLrK2q40LovlaEj
         neuUOoy5lP8rhamV48PqG+ZCkUoSWijvkGwmkp4x1aI0f7tJWp4G3NZfq8hFn+blA4
         2XNqdLcnlCzhTH0FRCm7MjnnNHonDn3ju0wlj5DpckWnHk9kpjt/sKHnoBCMM4/Tch
         OXXpvyP2rRnPA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 3F3D7C009;
        Wed, 10 Nov 2021 00:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1636501855; bh=vmSFDaCPi8DnwE17dsxm2GHByi1ky6lumSc6dbJflws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rP43Jc72HIxeVOrsytav2Cyo04kI0YwXvqTcaxfUsekRISzuC5q1zTQNp9xMrcMoh
         xbhJQjbEg1b/Dyg8OxjkBrjsUyPC3bOcTsdopSklmvYcbEzC9jWrDGuQEhmEpigZ8w
         hi9Ee1MlaKRZFQQTX/6jyG99FdCbGIRCI3YqAZqYcWiLrPvCpzGyJrfH3PVuUBKCbF
         CNGEroGhwrvK+HPZmtT+dA8vz/o8dldS1fPz/nQGHZ3OdN1JhQznC+i9PQpVD2KzPt
         +9ittHCJY5xSgC0uWPfqhPf5n2lxTZsl9odepejIyzsvB7jC4SxBD5v3gUQZYx1Rv8
         AejT/hnqS+vmg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5f0b9f15;
        Tue, 9 Nov 2021 23:50:49 +0000 (UTC)
Date:   Wed, 10 Nov 2021 08:50:34 +0900
From:   asmadeus@codewreck.org
To:     cgel.zte@gmail.com
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fs: 9p: remove unneeded variable
Message-ID: <YYsJSsihm05kKFgh@codewreck.org>
References: <20211109114343.132844-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109114343.132844-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com wrote on Tue, Nov 09, 2021 at 11:43:43AM +0000:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./fs/9p/vfs_file.c: 117: 5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Sure, why not.
Queueing this patch.

-- 
Dominique Martinet
