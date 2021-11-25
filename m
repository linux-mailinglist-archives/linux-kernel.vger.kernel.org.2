Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4445DF76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbhKYRTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:19:54 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55527 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235101AbhKYRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:17:53 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 77B263200E82;
        Thu, 25 Nov 2021 12:14:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 Nov 2021 12:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=MRbn5e6m1y/4TZefRh+adX8Q0JT
        3M5qVzD7hR+Z5Adk=; b=R++7kqaStJ6ivChRZuiOEPgd4ArNeWCVpwbwNoOMedh
        TEtZXZAtAOhsFxqEcbbpV9dSi1+ZoZsTY6ibdZMuiVF+UwwDWhpyl1AxdlXsSg+S
        h50KCkOgGLCnTCQMbwh46/TAJRVOCYT0kX/SSAXePbwKF/qaHFmlfBmxcS7rRJgA
        PGkMbbHg6S6ZaepDO+qEeo5a1jS04iLnsnVdhpdaPvWgsaypW3/ZpWpML8qZ8Pvc
        Kbu2VmwWXOdzNVVP/jFDWZpcNkeYgLMpG2DO9ySmTxYtu9XeDSAf1JJ+vv6DH9wd
        Jx+iIK20sDOikNURtAMpiT3GPi7k1w7dRvTk0giW/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MRbn5e
        6m1y/4TZefRh+adX8Q0JT3M5qVzD7hR+Z5Adk=; b=bfzOPyZKDnIfO4jChZN+3x
        Ejw0mc2lBfZm0bctEdr91lbwyUL3bI2FwY0pysWSTNkuMpqFabQ7AO+g9d1eA3F0
        R1fd6fnqzYjQ9DdLWP+9kGDVFI1GzrHZGztxLjn4mBliu6u5IbGBOd0Q7bQ4wYpp
        ndasYHBLTp2skHIpufi7i8uIGP18mlwwEj8tSkMa91kRBlVdgXq8P1vWIgEq0yRO
        DU/yKIJGdW/oWVoLUx3yb2dgfbMD059pM2W4ZBsBU88+bocwBe+X56mWUeqUmKx7
        TCgbDTD6uXn8yiuUnsAPlRI4br71RWhJmAS3/5zio8wALTvttXbELic3u/OBJg2Q
        ==
X-ME-Sender: <xms:f8SfYS1fT2y5M3sCvkkO2AGkuR9BjuEtyecGgK0Gi2QkrP6vbqVDuQ>
    <xme:f8SfYVEQwHiEECcjJwYgmnIQaKT6kDcNXwnWNZeX5LedbUSm15XGHG-I4s6S418wX
    dfAUiD4KB1Hjg>
X-ME-Received: <xmr:f8SfYa4QfDgEhLGkaNyRNNDgY0NC0oWHiEkXQaea4d9Y4_E1UYyQ6Oy--QjRhyLIalmCWZkxeEaxKRvVu-LUrvWGPBSC7DGl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedtgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepkeduhefhhe
    fggfeggedtueeiffehfeejgfduiedtkeegieekfeegudfhgfejkefgnecuffhomhgrihhn
    pehkvghrnhgvlhhnvgifsghivghsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:f8SfYT3aGg0MFH_8RAsGYOb-4HCq1U8ccmM_6fx3WmZ6eBVNy0YXTA>
    <xmx:f8SfYVF-AQcyVWWKfWBdseS2cIDN4Sg5KNGpaj0wR0MkOsp_1jgMsA>
    <xmx:f8SfYc8qsoQvWPkxipvHfDa0vASNNG50PopSZNAmH7yr9Oh47lSGaA>
    <xmx:f8SfYbaAKFaLIMioJ6pdgKsFfmMRQ3goJKjxJq9rb4Cq5MnB4jjRtA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Nov 2021 12:14:38 -0500 (EST)
Date:   Thu, 25 Nov 2021 18:14:36 +0100
From:   Greg KH <greg@kroah.com>
To:     Zoeb Mithaiwala <zoebm@google.com>
Cc:     dan.carpenter@oracle.com, trivial@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 3/3] Staging: rtl8712: Fixes a camel case variable
 name style issue
Message-ID: <YZ/EfPYxpsXg/gSm@kroah.com>
References: <20211122103931.GA6514@kadam>
 <20211122170335.1468730-1-zoebm@google.com>
 <YZ4Nej0yftiWh5rc@kroah.com>
 <CANMHzA4U-qc3mqz5XV4YOex-=CtsJ1UA2Xv4VaEQsf66Qfnh7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMHzA4U-qc3mqz5XV4YOex-=CtsJ1UA2Xv4VaEQsf66Qfnh7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:37:37PM +0530, Zoeb Mithaiwala wrote:
> > Where are patches 1/3 and 2/3 of this series?
> Apologies, I was unaware that the preferred method is a single email containing
> all the patches instead of a reply on the thread with only a single
> latest patch.

No one could work with a reply thread like that, right?  Would you want
to review patches sent that way?  :)

> > And this looks like it does not apply to any tree at all, are you sure
> you made it against the correct kernel branch?  If so, what one?
> This was against torvalds/linux, but I just saw that
> https://kernelnewbies.org/FirstKernelPatch suggests using gregkh/staging,
> I will clone and make further changes on that.

Wonderful, good luck!

greg k-h
