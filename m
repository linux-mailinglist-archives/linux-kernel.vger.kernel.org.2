Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CED36F0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhD2UCD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Apr 2021 16:02:03 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51970 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbhD2UBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:01:37 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id ED5E11C0BA5; Thu, 29 Apr 2021 22:00:49 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:00:49 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 003/190] Revert "media: sti: Fix reference count leaks"
Message-ID: <20210429200049.GA1175@bug>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210421130105.1226686-4-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-04-21 14:57:58, Greg Kroah-Hartman wrote:
> This reverts commit 6f4432bae9f2d12fc1815b5e26cc07e69bcad0df.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.

NAK. This fixes minor bug and should not be reverted.
										Pavel

> @@ -272,7 +272,6 @@ static unsigned long int hva_hw_get_ip_version(struct hva_dev *hva)
>  
>  	if (pm_runtime_get_sync(dev) < 0) {
>  		dev_err(dev, "%s     failed to get pm_runtime\n", HVA_PREFIX);
> -		pm_runtime_put_noidle(dev);
>  		mutex_unlock(&hva->protect_mutex);
>  		return -EFAULT;
>  	}
> @@ -555,7 +554,6 @@ void hva_hw_dump_regs(struct hva_dev *hva, struct seq_file *s)
>  
>  	if (pm_runtime_get_sync(dev) < 0) {
>  		seq_puts(s, "Cannot wake up IP\n");
> -		pm_runtime_put_noidle(dev);
>  		mutex_unlock(&hva->protect_mutex);
>  		return;
>  	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
