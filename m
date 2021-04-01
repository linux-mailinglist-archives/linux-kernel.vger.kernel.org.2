Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4D351F09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhDASwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:32782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237735AbhDASh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4CB610A5;
        Thu,  1 Apr 2021 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617284912;
        bh=IyraKdpJ2oYWpmotaNFdZ69p37ZZH8bB7J1kZKDDjv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=opiHfB3+wpApfc00/UDE+cJtyFlsBxWynkWVlx0pZYyXTJ8nRWwxHxi1oLPdXgIpu
         GYyf0bvEHDJjxIjAB0J2ydskknMzxD9idfU0nx7TNllC29rObFvyErOK7K9gaLQHy0
         r4IjKVnQ7SBFiCXng1BCsFq6KUzMVNUFZau6JbU4sfCYYBT9+tBs7FNuVq8mLXpxVV
         Z17JR+Lz+e8DicDnMl47kkHGzna+BtNoXPCe9TeNKh5WX0AZWIlDrXYfPlvVaJ1NJz
         RYDTWuUgUWQ5m9F91xYuw6tQcmT2urIz3BOohxm0gZSC9Mlk1T42rxJWGrMIJBtmOR
         m82/5GlBxrusQ==
Date:   Thu, 1 Apr 2021 15:48:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/2] audit: document /proc/PID/loginuid
Message-ID: <20210401154827.2f801300@coco.lan>
In-Reply-To: <14139c54992a4b50448fbbf07ebbfed743e09f3a.1616095045.git.rgb@redhat.com>
References: <cover.1616095045.git.rgb@redhat.com>
        <14139c54992a4b50448fbbf07ebbfed743e09f3a.1616095045.git.rgb@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 18 Mar 2021 15:19:10 -0400
Richard Guy Briggs <rgb@redhat.com> escreveu:

> Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
> loginuid through proc")
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid
> 
> diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> new file mode 100644
> index 000000000000..e7c100b9ab18
> --- /dev/null
> +++ b/Documentation/ABI/stable/procfs-audit_loginuid
> @@ -0,0 +1,15 @@
> +What:		Audit Login UID
> +Date:		2005-02-01
> +KernelVersion:	2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
> +Contact:	linux-audit@redhat.com
> +Format:		%u

The ABI definition doesn't include a "Format:" symbol. See:

	Documentation/ABI/README

For the valid ones.

This change causes a warning at the ABI parser:


	$ ./scripts/get_abi.pl validate
	Warning: file Documentation/ABI/stable/procfs-audit_loginuid#5:
		tag 'contact' is invalid. Line
			Format:		%u
	Warning: file Documentation/ABI/stable/procfs-audit_loginuid#21:
		tag 'contact' is invalid. Line
			Format:		%u

You should either drop it or add it to the parser and to the README
file, if the ABI maintainers are ok with such new field.

Thanks,
Mauro
