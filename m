Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8500D3A8940
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFOTLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:11:19 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37477 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhFOTLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:11:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 309FE16B0;
        Tue, 15 Jun 2021 15:09:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 15 Jun 2021 15:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
        date:from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        oc/qz9T7MURmvxgoaDmQ5ipajw1eWWTktl7kdX6kYoo=; b=LMawjffumfaxcQKa
        1NfkS2YSM6H3YmSICVtU7wwisWjdWiBqQ3Tl0wqd2YtBjivaJp8sjOOpQEpoBsL7
        +TFdo0kz1+0Wvz1xfDBC8O/jD1g2X3SG7c1Gbrvyvl1KPu6O9qm5BCE+H+w2j4wA
        XWE5vVBoOerAy/xwy2lG0WGi11imVB0qrTw/5h28Fi16vlH8WULnbQbRJbn0UFwb
        k+gbLBndfQDl26h7bRf3tXp/5EobC5BjoB8gdG9aCCj1EZ/xWUohkFVO5JHiNXcr
        +2w8WOtbnX0cnii+e7JocM06sa4/RAIh13rLIU81KzvZFE+CJgyd6Gg8qqHmDzXf
        iwyR5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=oc/qz9T7MURmvxgoaDmQ5ipajw1eWWTktl7kdX6kY
        oo=; b=RgisfqTDcKG9JghhAGnxWRJTGnsx+trh/ZXtMqTOzebHLd5Ky4FlKnk4G
        TLoDHTQrNC7TdxlM5lJEqJ5kGCFLcj5BvmU4lglnIcz+R2v1fmo9ZXeNcTIaMeV6
        n89mOj5ZuKPvqt1sOZ1+1YpVO9uZCBaQz7XuxnDCqFlC/xiJr0kjwwuPGXBCfyRV
        jzJTdpg5nKBJF0e07dSN2zam11blZ/y3mDW3FSkxVTwcO3ktg9Dd2bqUarVZhh7w
        vvqZj3z4pUJWlwUt3PgZRmkCc7j6XhWPNaa64QO4J2limShaC8hkNX5Utkt6qGd1
        /eKF5MO8U+iv1dSlQa9UvtYlctmUw==
X-ME-Sender: <xms:2PrIYA5K3EPlqQZhmUIfJ2hlvxlsuyOp2lxPsTcwd5gnZ_3hHzX1yA>
    <xme:2PrIYB44MoAW6XvkzFwcXsOruWcs7cm9wVLZfOoHGpen7XlJjTHIGgUfg8KgdoHvM
    XP0_wf-mkIS32dE3T4>
X-ME-Received: <xmr:2PrIYPcw1WqyfRwAj9z7FqnKNn7LtP494NGyOzm-uqcUsA6vjg76fyMHZdF132CePo06kQ51HQPqWD1w6AcIGzU_24xsDyTvByKVi4zvOmIMLSaD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefrrghu
    lhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpefghfehtdevffevffehheduhfdtveekhefffffgkeevieeghefgjeevgeehgeet
    vdenucffohhmrghinhepphgsrghrkhgvrhdruggvvhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvh
X-ME-Proxy: <xmx:2PrIYFIvW6EDbupFIv-PZ04tOeeYhEH8utvCv9si3ZNd6hQkN4t7bw>
    <xmx:2PrIYEKWMpjKb9fmnLNpgEie6oTeGi_IFYhZ8wmuw17EyLMSWnSuzQ>
    <xmx:2PrIYGziR4LyCNTj8vYBoJkIV_Oge5mI1p2P9pMHFA7bivPzBFUqMw>
    <xmx:2PrIYI2pKSRvwh_Gt9ve93T7Gub9FTeNE0_wcl7_Ylj7JzlgVT5ufg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 15:09:11 -0400 (EDT)
Date:   Tue, 15 Jun 2021 20:09:08 +0100
From:   Paul Barker <paul@pbarker.dev>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Use python3 to run spdxcheck.py
Message-ID: <20210615200908.0000367c@pbarker.dev>
In-Reply-To: <CABJPP5Ch4oTnrVZxSO3qLXO2M0xawLJpBO-T5+L7EJDRH3s1Hg@mail.gmail.com>
References: <20210615185206.7701-1-paul@pbarker.dev>
        <CABJPP5Ch4oTnrVZxSO3qLXO2M0xawLJpBO-T5+L7EJDRH3s1Hg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 00:28:14 +0530
Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:

> On Wed, Jun 16, 2021 at 12:22 AM Paul Barker <paul@pbarker.dev> wrote:
> >
> > Since commit d0259c42abff ("spdxcheck.py: Use Python 3"), the
> > shebang line in scripts/spdxcheck.py says the script should run
> > with `python3`. However, checkpatch has been explicitly running
> > this script with `python` so it needs updating to ensure that
> > Python 3 is used on all distros.
> >
> > Signed-off-by: Paul Barker <paul@pbarker.dev>
> > ---
> >  scripts/checkpatch.pl | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 23697a6b1eaa..5e5e3a53461b 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1084,10 +1084,10 @@ sub is_maintained_obsolete {
> >  sub is_SPDX_License_valid {
> >         my ($license) = @_;
> >
> > -       return 1 if (!$tree || which("python") eq "" || !(-e
> > "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
> > +       return 1 if (!$tree || which("python3") eq "" || !(-e
> > "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
> >
> >         my $root_path = abs_path($root);
> > -       my $status = `cd "$root_path"; echo "$license" | python
> > scripts/spdxcheck.py -`;
> > +       my $status = `cd "$root_path"; echo "$license" | python3
> > scripts/spdxcheck.py -`; return 0 if ($status ne "");
> >         return 1;
> >  }
> > --  
> 
> Hello,
> This change was already added by Commit c739ec2da1ea
> ("checkpatch: scripts/spdxcheck.py now requires python3")
> in linux-next.
> 
> Thanks,
> Dwaipayan.

So it is. Apologies for the noise.

-- 
Paul Barker
https://pbarker.dev/
