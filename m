Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DFD459112
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhKVPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbhKVPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:15:44 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:12:37 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z18so23772105iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/Ts0Os9qMFGThwHOtCiyhHMh/4YYH+c2424NHLIYCM=;
        b=badXmSjTu1JoDNUZ9NDIV7spgpAjIoEfdD9ic1e77G7P2LHAXwYp9epDLMgiUYLnav
         9W69UkENu4Ov86ohNMq2B2JZdBNLHZT4aDyzuF8gynIyOdI/0+WDNUWSX3Wag4aEMjqT
         mP5w8mu7pAseUIlqrlv7cZ6id4iI2ZPVTwQBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/Ts0Os9qMFGThwHOtCiyhHMh/4YYH+c2424NHLIYCM=;
        b=VBNfX5OnPM1VE3EhPmQ0AZB1dhguurd5vGYrH6/k5KJ+1PBmv7Rv566ThelnWY6raw
         U6TBLarwlAM8h46PkCiW2HK8DBh+Uka0QGgtgS8poRzaVB7kZrpdBmFBFTffPZWNK+Vq
         ZTZwiIvnxA6NI4zZdZxAdC/3lgCaZ5TRzrJIy5DdYrVr/1AVzlX/d1/ZZqVuu0YWf3Vs
         0sbc4uEfa5tPfYMCjwlYCJolQpWQDSLhYUHmqT09SidbJBNPIE4jbOCi723UmwV4vuMX
         cdOYzZrlHsua1C6lD2LMxtR6Ei/X2JDQg4F/+hm6pBmRDcwb9F86aZIANwchgkH0rFMl
         i8ew==
X-Gm-Message-State: AOAM5310f2knnUSJSkU8Kli7nkoKabP7AXcjUinydxbr90M0fwpaGeed
        3vpoZyAJbrZ6r3+ZpZc4tXy4wg==
X-Google-Smtp-Source: ABdhPJwbnPYUWBVjPezWcamXeiCUf/myETmHg+GaUYaQq5hNj/HU+vHelq4BAjqnuTeQmqLr7JkmGA==
X-Received: by 2002:a02:6064:: with SMTP id d36mr49689614jaf.80.1637593956072;
        Mon, 22 Nov 2021 07:12:36 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id f5sm5198012ioo.34.2021.11.22.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:12:35 -0800 (PST)
Date:   Mon, 22 Nov 2021 10:12:33 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/1] Create 'Reported:' and 'Reviewed:' tags for
 links in commit messages
Message-ID: <20211122151233.54xtnpwdmnrdj3jf@meerkat.local>
References: <cover.1637566224.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1637566224.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 08:33:41AM +0100, Thorsten Leemhuis wrote:
> The following patch proposes to create two new tags for mentioning links in
> commit messages. They are meant to make it obvious what provided links are
> about, which is useful for both users and scripts studying commits.
> 
> The new tag 'Reported:' is meant to be used for linking to bug reports, while
> 'Reviewed:' should point to the last review of the patch in question. They
> supplement 'Link:', which until now has been used for these two as well as other
> purposes; it stays around for the latter use case, for example for links to PDFs
> or webpages with background information relevant for the patch.

As an alternative, I can offer that we continue to use Link: trailers with
extra data following the hashtag, as is already done for other trailers:

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=215101   #report
    Link: https://lore.kernel.org/r/fobarbaz.5551212@localhost #review

Note, that this merely for completeness, not in opposition to the proposal. I
find the "Link:" trailer to be semantically redundant, since what follows is
already clearly a hyperlink. Adding "Link: " in front of it is only necessary
for consistency and machine parsing reasons.

Regards,
-K
