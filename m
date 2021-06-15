Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A03A7D49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFOLfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOLfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:35:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A17861107;
        Tue, 15 Jun 2021 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623756793;
        bh=9+5iyCctCQAgAcMSlpqZHL0gJCffhwjZ3OGMh8bKo40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8n6QFnmPCBQJLYEwXZU4Th9ZC5sPFSgloEeM8cVIXRvvy4duwk/mcF+BQ/0vimUB
         /76YgsgTvguKFo/Ca0eAn7Iv+vzx4cugVCczPOGQw9c6c/1ax+jaxS15zB15aVAguH
         url8LPWa2zGRURNYcoQyjDvY5YX2oMD7gXwekV4U=
Date:   Tue, 15 Jun 2021 13:33:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Hannes Reinecke <hare@suse.de>, containers@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: device namespaces
Message-ID: <YMiP90KPQhpOyvlN@kroah.com>
References: <877dj4ff9g.fsf@disp2133>
 <20210609063818.xnod4rzvti3ujkvn@wittgenstein>
 <b9ea9116-7120-b0a7-b739-dd8513e12c5e@suse.de>
 <20210609072108.ldhsxfnfql4pacqx@wittgenstein>
 <85a0d777-dea6-9574-8946-9fc8f912c1af@suse.de>
 <20210609080918.ma2klvxkjad4pjrn@wittgenstein>
 <87v96k1d65.fsf@disp2133>
 <c504a8c6-73f8-b45c-6d6b-6f5a1300ab3a@metux.net>
 <874ke0s60c.fsf@disp2133>
 <2bee9206-ca4a-8456-fabf-9557db599545@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bee9206-ca4a-8456-fabf-9557db599545@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:24:24PM +0200, Enrico Weigelt, metux IT consult wrote:
> @Greg: what's your take on that iterator idea ?

I want you to stop talking about ideas, and try to implement them before
this conversation wastes anyone else's time and energy.

There is a good reason we do not do this type of "let's discuss things!"
in the kernel community, and that is because almost none of it matters
without working code.

So please, let's see some patches that implement your ideas and then we
can discuss them.

Until then, consider this thread ignored from me.

greg k-h
