Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF41236A7D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhDYOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 10:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhDYOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 10:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EF45611BD;
        Sun, 25 Apr 2021 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619361446;
        bh=jMYmjgxoshd5i2hdR1ILX40a2m685etEU96tYo0iqEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLAyN8Dw9e30+s9nofXZfQYqs3rrJ6guprQQJWV/EtwpkKTjpftrW6ezYJKveCSEI
         AycpHU2zuuhmGuiNxn7kYmGIkhWCTTKc93tau6MiaYaObYaaz97ZUEv5rCjO5YdzNt
         RAT+JNEY9c0xeLnBiKjVntmmDGDkWm2SjDSELD24=
Date:   Sun, 25 Apr 2021 16:37:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Qiushi Wu <wu000273@umn.edu>, Aditya Pakki <pakki001@umn.edu>
Subject: Re: An open letter to the Linux community
Message-ID: <YIV+pLR0nt94q0xQ@kroah.com>
References: <CAK8KejpUVLxmqp026JY7x5GzHU2YJLPU8SzTZUNXU2OXC70ZQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8KejpUVLxmqp026JY7x5GzHU2YJLPU8SzTZUNXU2OXC70ZQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 05:30:50PM -0500, Kangjie Lu wrote:
> April 24, 2021
> An open letter to the Linux community
> 
> Dear Community Members:
> 
> We sincerely apologize for any harm our research group did to the
> Linux kernel community. Our goal was to identify issues with the
> patching process and ways to address them, and we are very sorry that
> the method used in the “hypocrite commits” paper was inappropriate. As
> many observers have pointed out to us, we made a mistake by not
> finding a way to consult with the community and obtain permission
> before running this study; we did that because we knew we could not
> ask the maintainers of Linux for permission, or they would be on the
> lookout for the hypocrite patches. While our goal was to improve the
> security of Linux, we now understand that it was hurtful to the
> community to make it a subject of our research, and to waste its
> effort reviewing these patches without its knowledge or permission.
> 
> We just want you to know that we would never intentionally hurt the
> Linux kernel community and never introduce security vulnerabilities.
> Our work was conducted with the best of intentions and is all about
> finding and fixing security vulnerabilities.
> 
> The “hypocrite commits” work was carried out in August 2020; it aimed
> to improve the security of the patching process in Linux. As part of
> the project, we studied potential issues with the patching process of
> Linux, including causes of the issues and suggestions for addressing
> them.
> * This work did not introduce vulnerabilities into the Linux code. The
> three incorrect patches were discussed and stopped during exchanges in
> a Linux message board, and never committed to the code. We reported
> the findings and our conclusions (excluding the incorrect patches) of
> the work to the Linux community before paper submission, collected
> their feedback, and included them in the paper.
> * All the other 190 patches being reverted and re-evaluated were
> submitted as part of other projects and as a service to the community;
> they are not related to the “hypocrite commits” paper.
> * These 190 patches were in response to real bugs in the code and all
> correct--as far as we can discern--when we submitted them.
> * We understand the desire of the community to gain access to and
> examine the three incorrect patches. Doing so would reveal the
> identity of members of the community who responded to these patches on
> the message board. Therefore, we are working to obtain their consent
> before revealing these patches.
> * Our recent patches in April 2021 are not part of the “hypocrite
> commits” paper either. We had been conducting a new project that aims
> to automatically identify bugs introduced by other patches (not from
> us). Our patches were prepared and submitted to fix the identified
> bugs to follow the rules of Responsible Disclosure, and we are happy
> to share details of this newer project with the Linux community.
> 
> We are a research group whose members devote their careers to
> improving the Linux kernel. We have been working on finding and
> patching vulnerabilities in Linux for the past five years. The past
> observations with the patching process had motivated us to also study
> and address issues with the patching process itself. This current
> incident has caused a great deal of anger in the Linux community
> toward us, the research group, and the University of Minnesota. We
> apologize unconditionally for what we now recognize was a breach of
> the shared trust in the open source community and seek forgiveness for
> our missteps.
> 
> We seek to rebuild the relationship with the Linux Foundation and the
> Linux community from a place of humility to create a foundation from
> which, we hope, we can once again contribute to our shared goal of
> improving the quality and security of Linux software. We will work
> with our department as they develop new training and support for
> faculty and students seeking to conduct research on open source
> projects, peer-production sites, and other online communities.  We are
> committed to following best practices for collaborative research by
> consulting with community leaders and members about the nature of our
> research projects, and ensuring that our work meets not only the
> requirements of the IRB but also the expectations that the community
> has articulated to us in the wake of this incident.
> 
> While this issue has been painful for us as well, and we are genuinely
> sorry for the extra work that the Linux kernel community has
> undertaken, we have learned some important lessons about research with
> the open source community from this incident. We can and will do
> better, and we believe we have much to contribute in the future, and
> will work hard to regain your trust.
> 
> 
> Sincerely,
> 
> 
> Kangjie Lu, Qiushi Wu, and Aditya Pakki
> University of Minnesota

Thank you for your response.

As you know, the Linux Foundation and the Linux Foundation's Technical
Advisory Board submitted a letter on Friday to your University outlining
the specific actions which need to happen in order for your group, and
your University, to be able to work to regain the trust of the Linux
kernel community.

Until those actions are taken, we do not have anything further to
discuss about this issue.

thanks,

greg k-h
