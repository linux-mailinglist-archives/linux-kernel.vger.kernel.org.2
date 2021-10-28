Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E098C43E141
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhJ1Mvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1Mvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:51:52 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2A97C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:49:24 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9E7339200B4; Thu, 28 Oct 2021 14:49:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 973BA92009E;
        Thu, 28 Oct 2021 13:49:22 +0100 (BST)
Date:   Thu, 28 Oct 2021 13:49:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Johan Hovold <johan@kernel.org>
cc:     cgel.zte@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, fancer.lancer@gmail.com, andrew@aj.id.au,
        pali@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Yao <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers: tty: replace snprintf in show functions with
 sysfs_emit
In-Reply-To: <YXqV9V0eWhqFTc+i@hovoldconsulting.com>
Message-ID: <alpine.DEB.2.21.2110281342290.61663@angie.orcam.me.uk>
References: <20211028101350.14172-1-yao.jing2@zte.com.cn> <YXqV9V0eWhqFTc+i@hovoldconsulting.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021, Johan Hovold wrote:

> Where's the commit message?

 Or to put it explicitly: please always include a full description of any 
change submitted, where you explain what your change is needed for and why 
you have made it like this.

 Please refer to Documentation/process/submitting-patches.rst in the 
source tree for a full recipe for submitting patches, which says, among 
others:

"[...] The text should be written in such detail so that when read
weeks, months or even years later, it can give the reader the needed
details to grasp the reasoning for **why** the patch was created."

 Thanks,

  Maciej
