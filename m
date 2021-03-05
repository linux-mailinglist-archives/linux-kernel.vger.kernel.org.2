Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564CE32F6B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCEXik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:38:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62291 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCEXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:38:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF225121D7C;
        Fri,  5 Mar 2021 18:38:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JiJZnAx2HE7c1+BaJK3156FqSFU=; b=pf8Yxq
        mYIRallHhrew+bDCKs4rJzZ/1iyLfnMTd3W1BiIpG0Cp0ODy86JENO7MFiDNJXV4
        wnp2La68fW7o+bczGqxU/BBW71b15+a0vk/LSh4rmSNlfJ0SujdWoD9mW33q7N81
        3Q9T+MXf6rIFbJl/5gO4axWmRXc1DOZbA9d40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KaA5BH3zTbiIwrZ+QfNopbPnRUcE5BJO
        2wRc9lHUyP1W35en67tPhgzp85h0hC5ovtlzsUlPR/dJz/Ex1Uk30KSk+3+E5Ag7
        2PySWVtdClOBKHd5P/fKhAhrbigmJ2v3LgM+ttqmqXtE2ev2pHylTyTUIujFRunx
        v0955k+Qv8o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7A55121D7B;
        Fri,  5 Mar 2021 18:38:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 41F89121D7A;
        Fri,  5 Mar 2021 18:38:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: A note on the 5.12-rc1 tag
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
        <YEFIXFyP5tWrPDMw@localhost>
        <CAP8UFD07ezNOXU5Q3RZAHOJGMjuaJY-R=x=hhQcQvYOAKzKF2g@mail.gmail.com>
        <xmqq8s71bhfm.fsf@gitster.c.googlers.com> <YEK5d+8TSqS/rdMu@localhost>
Date:   Fri, 05 Mar 2021 15:38:16 -0800
In-Reply-To: <YEK5d+8TSqS/rdMu@localhost> (Josh Triplett's message of "Fri, 5
        Mar 2021 15:06:31 -0800")
Message-ID: <xmqqmtvh893r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD062490-7E0B-11EB-91DC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

>> It is trivial for you to fetch the refs/notes/do-not--checkout notes
>> tree from me and merge it into your refs/notes/do-not--checkout
>> notes tree, I would think; "git notes merge" may have room for
>> improvement, but essentially it would just want a union of two
>> sets, no?
>
> My primary concern about notes is that they require manual
> action/configuration in order to share. I was looking for a solution
> that would automatically protect anyone who pulled from linux.git
> (directly or indirectly), without them having to specifically take a
> separate step to sync this information.

If "without any configuration" is a hard requirement, then by
definition you'd need to live with what you get from "git clone" and
"git pull" alone, so be it the notes or any other mechanism, there
currently is nothing that lets you do the "skip this part while
bisection".


