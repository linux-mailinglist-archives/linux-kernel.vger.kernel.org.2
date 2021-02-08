Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F200231422A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhBHVqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhBHVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:21:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05505C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 13:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=O86lNpBRnEs3afDwWTUQ9xX0klYvN5RBrVkkBYUenXk=; b=Ifxj6MBivODlzSxqgWEv6GG6EB
        sPXNpzVIZRxjOLl26t3TMSnwm330607ESm7Hfc2Vl3W5MkPjGATg2FThUI0x4pQNsJN3ncXOvO0vy
        2i3DndUZ6jpn6Hel8mVLvUXjlHwyMDAk06/QhqOV68DlhMCx+mfmsd2vZoK/0a3S2LlrlLxrMO6ru
        wQBvNQOa0jTuaPASxNZw6c7zbJd/LLtvIqMb/QAuPLtHS9yDGUXJvrZM8qqSM16UfbjQ188frrr04
        N46Z0gI3/7aB3+HiwDy9IESkmcWBwgx1wlVXvvli2pq7rclR8nni27xUQqy5erZNfDva2mJjEDxeO
        6/jTSCMw==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9Dy3-0000yK-10; Mon, 08 Feb 2021 21:21:11 +0000
Subject: Re: [PATCH]: checkpatch: Fixed styling issue
To:     Mukul Mehar <mukulmehar02@gmail.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210208195116.GA19781@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <912a1fcf-4298-5416-805d-3571df66d4d8@infradead.org>
Date:   Mon, 8 Feb 2021 13:21:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208195116.GA19781@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 11:51 AM, Mukul Mehar wrote:

More comments (probably duplicates):

a. The "checkpatch:" in the subject says that you are making a patch
to the "checkpatch" script. You are not doing that. The subject should
be more like: "staging: most: fix a style issue in sound.c" e.g.

b. This comment:
This is my first patch.

should not be in the comment message. If included at all, it should be
after the "---" line, like so:

---
This is my first patch.

<then the diffstat>.


thanks.
-- 
~Randy

