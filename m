Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4438ECD9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhEXPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhEXPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:16:02 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C1DC061344;
        Mon, 24 May 2021 07:52:56 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b5so5212502ilc.12;
        Mon, 24 May 2021 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yW6xxqoFqjdbNxGybwNPD8otEN5g9CMdaIvijDpl8O0=;
        b=YG998/Adp6FNLqctJvDtccznSREYmD1mmYlwzYnDEAb3j2lEoIHiRuwAaZ7jRu532r
         x5zGs1YGgjCF0mNuWeJtPGQN7gjo86NwKcarGrjw3NTlK2oiPvP69c8ujzo7gnY/6Gpq
         64n3RWSkERQEwI2Yol1Hvx6lDX8Qf2Q37J50cFLC8z67y+f6N9mH7NgE0OZiisSiTF+K
         TfUQw4AprvwBkE4jtL98xZhGeC72lG76tKl03DUi0PK/wl7qQ2gD5uYAV8MxUZucUygt
         1oqh0ZfqMDQCMLNEq3ONkvy+8goSVdXLqGs43UPzJJWWxhdd6wPt99yEhQmg87wIkcNr
         3rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yW6xxqoFqjdbNxGybwNPD8otEN5g9CMdaIvijDpl8O0=;
        b=GfPJjPFJrAZt/2zD5QqFVdhLxjQ7R1JdgyrsTfD0+hzTuOnO0DP8ZbIQoEgX8npce9
         H7HZcNzqrphid+JDRSmMpbp+c7AaIuEyMvew7ntsNgiFSlxyP2yh2irBcSXdwPV0PKt4
         1ukR58Sa+fPlUEYaK6f0IivBhlFbdajwwIHAgiYTHT2bVrc9nWF5hEzMC1hLY/VA/A6i
         Mg+hYviUTcG8lIHkPaZ90wGU3XBG+HVi9YkXhI6t1COKuxyVDXnBcF01R4c+8U4MGIvb
         VguWXZcqMYYfaXNp6O0R5YfHfkA+RleCG0udoU7efTMtZlnoNVi2akociN0uqCyfD0ni
         kAnQ==
X-Gm-Message-State: AOAM532qn8yO0EDcnutVDeB5hnlc9vBvRCAkHLeRzx1QrLiTVEeuArrS
        XU9BvY98/QCD66sohhGBVIU=
X-Google-Smtp-Source: ABdhPJyf4JdMyvNDf4B94zYpXpKtQnc4BcErdNlGmC9cdsi061geJGkk3D0utp+nBI3kiroqRr/pRw==
X-Received: by 2002:a92:c5ca:: with SMTP id s10mr5953834ilt.32.1621867975418;
        Mon, 24 May 2021 07:52:55 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b10sm11047903ioz.35.2021.05.24.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 07:52:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8A4B027C0054;
        Mon, 24 May 2021 10:52:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 24 May 2021 10:52:53 -0400
X-ME-Sender: <xms:xL2rYN9s7JZK7Ki7BdlpqNe9XYHFRMDrInKNlhi7TE01XI1SphEW-g>
    <xme:xL2rYBvRBLRnpHtSfTSkHOX2yMujLoPDQGsU2Aicc8MczkK00l-a9CjgUdUNWhtz6
    8JmwQCtFNHCh4rJjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:xL2rYLCiLyBUkk6aekMIKrgnjrtIPPCw4mfUoTiAXKKiqOT1luf5aA>
    <xmx:xL2rYBfRlV8Ec925v5Tm2ob-gn3WlpvjrUtcOrcxu-fWqD8NYBfy0A>
    <xmx:xL2rYCN1HDwRQ3Kt9mH50e2X_D65IeTxCpKcAp_C2IJm_YMUU9UuNA>
    <xmx:xb2rYBfYgJEY1C7h1T-nLU5WcdguG-t-ZdBlAECUFixiBUp_Qd7I_ccxtIY>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 10:52:52 -0400 (EDT)
Date:   Mon, 24 May 2021 22:52:16 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@gmail.com>, Xiongwei Song <sxwjean@me.com>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: lockdep-design: correct the notation for writer
Message-ID: <YKu9oDtJ7l00k+Yh@boqun-archlinux>
References: <1621578594-13237-1-git-send-email-sxwjean@me.com>
 <e0c0302f-e63f-7eba-872b-85e21b0b1622@redhat.com>
 <CAEVVKH9nwPmQo8L-eRsWST+gPaJ73MSHZfJ-mM8qWvPaiejdrA@mail.gmail.com>
 <YKuAvt3WXBVASuhY@boqun-archlinux>
 <ab3c5c38-1447-99e1-ee22-9e5af906d8b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3c5c38-1447-99e1-ee22-9e5af906d8b4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 09:42:20AM -0400, Waiman Long wrote:
> On 5/24/21 6:32 AM, Boqun Feng wrote:
> > On Mon, May 24, 2021 at 12:24:00PM +0800, Xiongwei Song wrote:
> > > On Fri, May 21, 2021 at 11:17 PM Waiman Long <llong@redhat.com> wrote:
> > > > On 5/21/21 2:29 AM, Xiongwei Song wrote:
> > > > > From: Xiongwei Song <sxwjean@gmail.com>
> > > > > 
> > > > > The block condition matrix is using 'E' as the writer noation here, so it
> > > > > would be better to use 'E' as the reminder rather than 'W'.
> > > > > 
> > > > > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > > > > ---
> > > > >    Documentation/locking/lockdep-design.rst | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> > > > > index 9f3cfca..c3b923a 100644
> > > > > --- a/Documentation/locking/lockdep-design.rst
> > > > > +++ b/Documentation/locking/lockdep-design.rst
> > > > > @@ -462,7 +462,7 @@ Block condition matrix, Y means the row blocks the column, and N means otherwise
> > > > >        | R | Y | Y | N |
> > > > >        +---+---+---+---+
> > > > > 
> > > > > -     (W: writers, r: non-recursive readers, R: recursive readers)
> > > > > +     (E: writers, r: non-recursive readers, R: recursive readers)
> > > > > 
> > > > > 
> > > > >    acquired recursively. Unlike non-recursive read locks, recursive read locks
> > > > I would say it should be the other way around. Both W and E refer to the
> > > > same type of lockers. W emphasizes writer aspect of it and E for
> > > > exclusive. I think we should change the block condition matrix to use W
> > > > instead of E.
> > > The doc uses 'E'  to describe dependency egdes too. Should we change them
> > > to 'W'? Personally,  both 'W' and 'E' are fine.
> > > 
> > I also think Waiman's suggestion is solid, there are two ways to
> > classify locks:
> > 
> > 1.	W (Writers), R (Recursive Readers), r (Non-recursive Readers)
> > 
> > 2.	E (Exclusive locks), S (Shared locks), R (Recursive Readers),
> > 	N (Non-recursive locks)
> > 
> > And the relations between them are as follow:
> > 
> > 	E = W
> > 	R = R
> > 	N = W \/ r
> > 	S = R \/ r
> > 
> > , where "\/" is the set union.
> > 
> > The story is that I used the way #1 at first, and later on realized way
> > #2 is better for BFS implementation, also for reasoning, so here came
> > this leftover..
> > 
> My suggestion was based on the fact that it is harder to associate E with
> writer. So from a readability perspective, it is better to change the block
> condition matrix to use 'W' to make it more readable.
> 

Yes, I agree. It's probably due to the curse of knowledge, I cannot see
the difficultly of associating E with writer ;-) So thanks for pointing
out!

Actually there are two block condition matrices in my mind:

The block condition matrix describes the natural of block conditions of
write/read locks, this one provides better readability for lock users,
it can be used to answer questions like: which lock blocks another lock.

	|   | W | r | R |
	+---+---+---+---+
	| W | Y | Y | Y |
	+---|---+---+---+
	| r | Y | Y | N |
	+---+---+---+---+
	| R | Y | Y | N |

(answer whether row blocks column)

Based on this, we have a more abstract block condition matrix in
lockdep, it's used to reason about deadlock possibility and implement
the deadlock detection, it might not be the good one for normal lock
users to read.

	|   |  N  |  R  |
	+---+-----+-----+
	| E | Yes | Yes |
	+---+-----+-----+
	| S | Yes | No  |

(answer whether row blocks column)

FWIW, if we are going to put the second block condition matrix in the
doc, we'd better place it somewhere in the section "Dependency types and
strong dependency paths".

Just clarify a little while we are at it.

Regards,
Boqun

> Cheers,
> Longman
> 
