Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACF531EF01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhBRSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233305AbhBRQwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:52:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BE246146D;
        Thu, 18 Feb 2021 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613667066;
        bh=UiJoO9f05d/IEcVWcOSMmu4kK2DNYfzncgmF7M0/MI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qw8dHHGS6O4d2zSMZU/AvLTGm8l37ByEJ448BkoHYttzsoBfbBXYBga/46z+XHWmS
         qit7EBqisag5Nk0Oft7UsH+94QGQnoKCKoKu2N/BZ3SRYNhvCstV5ApszKhBMQ6c7x
         ltcX8wBfS6uhAO2HMhChF1VTZ9gBirHE7I0Ukm5NambydJoGaZjz/fukUdUOCtXXvu
         lnqVaKKMi/iEQIR8S9Jx4ZKcv4VAVYLKpPpf1PlosbpRPyODnMSyPujxSiDdn1cxZ3
         XEXDtXIJD4duXcJ6P0vW5CFBZjeYFmR/7i0w0HMl7/CkjdN5grYIx42KovbMo4A+LH
         byN+uNFvHkGcQ==
Date:   Thu, 18 Feb 2021 11:51:04 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218165104.GC2013@sasha-vm>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 11:48:21AM -0800, Scott Branden wrote:
>On 2021-02-17 1:40 a.m., Greg Kroah-Hartman wrote:
>> Following up on this as I did not hear back from you.  Are you and/or
>> your company willing to help out with the testing of 5.10 to ensure that
>> it is a LTS kernel?  So far I have not had any companies agree to help
>> out with this effort, which is sad to see as it seems that companies
>> want 6 years of stable kernels, yet do not seem to be able to at the
>> least, do a test-build/run of those kernels, which is quite odd...
>I personally cannot commit to supporting this kernel for 6 years
>(and personally do not want to backport new features to a 6 year old kernel).
>And customers are finicky and ask for one thing and then change their mind later.

Why would we commit to maintining an upstream LTS for 6 years then? If
no one ends up using it (and we don't want anyone using older LTS
kernels) we're still stuck maintaining it.

>We'll have to see what decisions are made at a company level for this as there
>are added costs to run tests on LTS kernel branches.  We already run extensive QA on

This sounds very wrong: it's ok to get volunteers to commit to 6 years
while the company that is asking for it won't do the same?

Shouldn't Broadcom commit to the work involved here first?

>whatever active development branches are in use and a subset on the mainline
>branch as well.  QA resources are finite and committing those for 6 years is
>not something that makes sense if customers drop that kernel version.
>Testing of the LTS kernel changes really moves out of our hands and into the
>customer's testing after our major releases to them.

Keep in mind that QA resources are generally more abundant than
engineering resources that need to actually backport stuff to old
kernels.

-- 
Thanks,
Sasha
