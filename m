Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0781A32A01A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575307AbhCBDzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:55:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:44642 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238227AbhCAWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:21:44 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2EDFD2B8;
        Mon,  1 Mar 2021 22:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2EDFD2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614637219; bh=6kRXwwaxFEtPBa+C5CSasyDpYyVF5qD9hdXkfVgVeXI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HFhIv/ZvlhGFAT/a30UXqSg9wUcPZasMSutNqiCS6J06QYRRNvlzsQuHK+bdEtnGG
         /d8q4wYAWlGCiO+T2R9DCQAWbyPQvYpCSwc/EA/epIYecotE/zfLjEOFQtfSW6UcUM
         e3RNsQhdxMrZhGXo4+z5rS8NsQMGbbKKjQvrrJ9c4HFM53xuZR4RMp+eDOMqPZ2wVX
         VjuUae5KG1YpYtsrhqQgdSMglx62qGjQsJKJvyZ/3/tGx8lTQ2RUSnYkGg3fCw5nV0
         zCry3YVpCp417qtegcv1hKsmoEz+0acu/3T8U9ytg6vL+nJqg6HNt2oE+UTpLLTZLs
         OORMeC6oW8Wdg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrey Vagin <avagin@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: ioctl: add entry for nsfs.h
In-Reply-To: <20210210182248.18101-1-rdunlap@infradead.org>
References: <20210210182248.18101-1-rdunlap@infradead.org>
Date:   Mon, 01 Mar 2021 15:20:18 -0700
Message-ID: <87mtvm1pp9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> All userspace ioctls major/magic number should be documented in
> Documentation/userspace-api/ioctl/ioctl-number.rst, so add
> the entry for <linux/nsfs.h>.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrey Vagin <avagin@openvz.org>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: linux-doc@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
> Feel free to modify the patch as needed.
>
> Probably don't need to backport:
> # Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
>
>  Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
>  1 file changed, 1 insertion(+)

Applied (rather belatedly, sorry).

Thanks,

jon
