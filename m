Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD51C3EFD07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbhHRGoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:44:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33447 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238280AbhHRGoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:44:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EA5175C0259;
        Wed, 18 Aug 2021 02:44:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 18 Aug 2021 02:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=zzoOCl2YreUt7MfN2Ool90MUXMU
        XImkpZjNooyEe0Ac=; b=qGyZU/e5mtYaTVwX0UHaEohjjaNINhPX+/hEggeB4Ed
        6t9xQ0PVlusJV2vv/yQXEAFBLFt8EOutsCmZo+4dPyOB2mA5uTho0w9KqlNc7E3b
        xUbukQFxgv+ETvU+XhqYsXWcun5+obn7tixApT3CqWT8yINgxTEjrxWuT5Qzl5Im
        ZTEwwIqaLVszK3b5ZEEK3J3XVXfJoDI081YA48xqhXlSGLkJjAja3wR/1KoPmlwI
        Jr4EkAb1sV847nRFhYofNoxEJlVxnQ6rI7AJlb+Av6ysLkNJXv+Ix0+IT6Ysr5sV
        7s5vSPqMiM2/1v9nd4BufHkFmImLxx1IIXzX39v0MbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zzoOCl
        2YreUt7MfN2Ool90MUXMUXImkpZjNooyEe0Ac=; b=rPRElJXU3AILQ5wm18OW7G
        9phavvnnMqDtV/bKmofjzcay6EJkxWt80+jBwEPS6CpyN+CcEvXb5Niy4hGbGY07
        lMZwlnv+b3v80adhb/LhIBi0h9L8KbaDJpIXP8b0PN889ZoAmdOXN6Ffp1izApmj
        yxHgOX0K+X6aQ6Mf5Y15rLofTMjwCUz5nJVPYQxh4Ajogm1Fb6epwfkbQC6h1jA3
        cdntNYeAV3DmNzByZ3A6zYywKXMnS1cIdGkmweVdkJiRG4p4KjJHTbDB7pscGFG8
        2/zspNHd+ihkuLSJCp7FGzaKK6SJZTB3OpOskj6OFq6qFnfPcsHmEg5cLrmuyLlg
        ==
X-ME-Sender: <xms:MqwcYfeIxDHEaLZsgOaI76wOfG6ZypfEqGgq0RO43cIfuFVx4GJV4w>
    <xme:MqwcYVNXZoE3EqaKeHzago-wY_dHeDZD5DvTCyYF-JOF7hc9aD-2TqG-Y_9a-6z8z
    RspGfIcxOivVw>
X-ME-Received: <xmr:MqwcYYgY7HzeiiZaQucD6mundeoYeQkSiVDbGBWZoCNZxfBQUM0hvz605h1UyVzLoXbUVSbjBq3h8xWDfNzreQo34VBPDVMf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeggddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:MqwcYQ8O1CB0LaescJ3AaPo3W-hcT1P_V4VDMiKYoquAfg3WR7qBJw>
    <xmx:MqwcYbs6A7OqsNptxLB5WMCQsokLeY-IJl-qu-SkrUfIXbwbaQJhdg>
    <xmx:MqwcYfGfbu5LbHF45H_DB9x8fh_fJ15es219_qP6QF5McihVSAuucg>
    <xmx:MqwcYRAzcuWCKSoKsCDDGxowcuG728y1C8YLVsdexeDcDSZDv2xTpw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 02:44:01 -0400 (EDT)
Date:   Wed, 18 Aug 2021 08:43:58 +0200
From:   Greg KH <greg@kroah.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     dan.carpenter@oracle.com, yangyingliang@huawei.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Remove unused including
 <linux/version.h>
Message-ID: <YRysLl5Yu/ngNOl3@kroah.com>
References: <20210818063653.2851-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818063653.2851-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 02:36:53PM +0800, Cai Huoqing wrote:
> Remove including <linux/version.h> that don't need it
> 
> v1->v2: remove "based on staging-next" from commit message
> v2->v3: add changelog to commit message

As the documentation states, these lines need to go below the --- line,
right?

Please fix up and send a v4.

thanks,

greg k-h
