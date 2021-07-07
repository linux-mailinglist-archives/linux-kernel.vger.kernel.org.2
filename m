Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF93BE272
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhGGFTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:19:03 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51427 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhGGFTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:19:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 05CB92B009B0;
        Wed,  7 Jul 2021 01:16:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 07 Jul 2021 01:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=bjg5mAKTQMSSAgmvaQ8z3hAoB2n
        Ww8pC6PmIiej0f00=; b=SgsfNJCCbXNkY6y5tFcEbf2PZ02Nurhsfsh8Nbm2DBe
        a0jxti7lxa6JTSNU5fa7BoiFaxeQDVmauQa8plvDk5zfLb6Amqdl67P5/9P6p48m
        cLXdSesz7a8rfCYOI2l66gDLPvbr6hFEyAnsVXKHRMVfVGYcPelI6lmGMoU5BJhk
        L6lyqKjXK8rgWyHlcOe9ZbXu9E+GX8apVy9nhkfKQmTbXRbLIpcMoV7nLyON0faG
        G+hSfUD2WZ/KLebOJ6OAPBEOE7pmMkx2n4FqBqc4dAekeHIBJ8bloffpy+2ZhNaW
        G0H1EwraxuTaMepi54Zk20WM6CICpNWfFaQWAqMgbqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bjg5mA
        KTQMSSAgmvaQ8z3hAoB2nWw8pC6PmIiej0f00=; b=U5bU/Hi5Bx5dUWnkSWhHxk
        YOX5srS4GLQuhQKwr7fr3oIqYIQxXFVSejEZb8at+VBIjh1nzNAr8NGVps/De+1B
        fdArQOR238VQRm1LlCu6Vm1jit40HUch5P8388Uro93SB/YyjqRB3bsHGVVZ6RBG
        aix9V6KO0YFSbzNXM+A8kVFAITymWKJ/PJcTJUaZdLJ64krRvCLbEKAT11vqMPD6
        qlY8t6lvPbF9VTMmck33dAxVwiZ8C2bT3/hnJMfunSAXCNlf9oWnQG61erFPK+yW
        XDXUd2iGMYcyU86y9Cj+o8/ufk2zmVmLGbUMGX6MWK7pEY/j90JclOuyHEOZLlwA
        ==
X-ME-Sender: <xms:nzjlYLkxM7G9sDGo9b4E3j5aq15exlr1rnXOp9SsTG1M160W2Y9CxA>
    <xme:nzjlYO19-v0NfeD75tNcdZ17rIZ5PBfhwQ90fL8HQuv_O4o7NkQme1-_ZNtlN6BHr
    Iaqxdil-KSD-w>
X-ME-Received: <xmr:nzjlYBrkpsQJAebFf6jWCOXSsyay2jnUzxhK0SiIzKfAGmf2Rx26J229YxrNpd0c9OkjLB49n5kb-rmSBHnLS4mgXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddugdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhrohgrhhdq
    jfgrrhhtmhgrnhcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnh
    eplefggeejffdtgeeutdefveevhfdtfeeufeefjefhleduuefgieegveelueejteffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgse
    hkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:nzjlYDnn2cQIq6LL9tTU-2adf6PhdxLRD_50OpzHlZaAWKf_y0Y3QA>
    <xmx:nzjlYJ1tVGmUy3Lov36erQawoqXR5KI-q8pOP_Z3GXEJTXv3vjH64Q>
    <xmx:nzjlYCtWEGc7ICxfQB4FM5qYMiwRmf4AScXrQXquqy-VJfDT83ikrQ>
    <xmx:oDjlYDNMlYEmS8fcXaZMq52KeU3AjQSJ-QWo4oqlJNiUW3hlEayB826C6Ho>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jul 2021 01:16:15 -0400 (EDT)
Date:   Wed, 7 Jul 2021 07:16:10 +0200
From:   Kroah-Hartman <greg@kroah.com>
To:     Norbert Manthey <nmanthey@amazon.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Coverity Scan model file, license, public access
Message-ID: <YOU4miygyerC2bvs@kroah.com>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com>
 <6f1cb856-fc72-cfd1-9bdd-b4dbf58c558c@amazon.de>
 <YOSj8kjDtjmUtcVP@kroah.com>
 <b5f5c38c-5691-816d-f14c-8a82be7d9456@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f5c38c-5691-816d-f14c-8a82be7d9456@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 09:06:33PM +0200, Norbert Manthey wrote:
> Backtracking to the original problem: is there a way to figure out the
> contributors of the current model, to get an agreement on the license to
> be used?

By sending html email, you are preventing the lists from seeing this
question, so you might want to start by fixing that on your end :)

greg k-h
