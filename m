Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C22425021
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbhJGJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:33:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:60352 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240712AbhJGJdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:33:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226106498"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="226106498"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 02:31:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="488899530"
Received: from roliveir-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.41.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 02:31:16 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v1 2/2] docs: submitting-patches: make section about the Link: tag more explicit
In-Reply-To: <d97daa2791a7598a6ee4e853d3c6b536919191d5.1633593385.git.linux@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1633593385.git.linux@leemhuis.info> <d97daa2791a7598a6ee4e853d3c6b536919191d5.1633593385.git.linux@leemhuis.info>
Date:   Thu, 07 Oct 2021 12:31:12 +0300
Message-ID: <87pmshyye7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> Mention the 'Link' tag in the section about adding URLs to the commit
> msg, which makes it easier to find its meaning with a text search. For
> the same reason and to also improve comprehensibility provide an
> example.
>
> Slightly improve the text at the same time to make it more obvious
> developers are meant to add links to issue reports in mailing list
> archives, as those allow regression tracking efforts to automatically
> check which bugs got resolved.
>
> Move the section also downwards slightly, to reduce jumping back and
> forth between aspects relevant for the top and the bottom part of the
> commit msg.

FWIW, we've been using the Link: tag in the drm-misc and drm-intel trees
to reference the patch (that became the commit) in the freedesktop.org
patchwork instance by message-id. This is almost exclusively the only
way we use the Link: tag, and we've been doing this for about 5 years
now. It gets automatically added by the tooling we use while applying
patches. You get to the discussion, patch series, and Intel CI test
results via the link.

For ages, References: tag has been used the way described in this patch.

BR,
Jani.

>
> CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/submitting-patches.rst | 32 +++++++++++++-------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index b0f31aa82fcd..8ba69332322f 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -96,17 +96,6 @@ instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>  to do frotz", as if you are giving orders to the codebase to change
>  its behaviour.
>  
> -If the patch fixes a logged bug entry, refer to that bug entry by
> -number and URL.  If the patch follows from a mailing list discussion,
> -give a URL to the mailing list archive; use the https://lore.kernel.org/
> -redirector with a ``Message-Id``, to ensure that the links cannot become
> -stale.
> -
> -However, try to make your explanation understandable without external
> -resources.  In addition to giving a URL to a mailing list archive or
> -bug, summarize the relevant points of the discussion that led to the
> -patch as submitted.
> -
>  If you want to refer to a specific commit, don't just refer to the
>  SHA-1 ID of the commit. Please also include the oneline summary of
>  the commit, to make it easier for reviewers to know what it is about.
> @@ -123,6 +112,27 @@ collisions with shorter IDs a real possibility.  Bear in mind that, even if
>  there is no collision with your six-character ID now, that condition may
>  change five years from now.
>  
> +Add 'Link:' tags with URLs pointing to related discussions and rationale
> +behind the change whenever that makes sense. If your patch for example
> +fixes a bug, add a tag with a URL referencing the report in the mailing
> +list archives or a bug tracker; if the patch was discussed on a mailing
> +list or originated in some discussion, point to it.
> +
> +When linking to mailing list archives, preferably use the lore.kernel.org
> +message archiver service. To create the link URL, use the contents of the
> +``Message-Id`` header of the message without the surrounding angle brackets.
> +For example::
> +
> +    Link: https://lore.kernel.org/r/git-send-email.555-1234@example.org
> +
> +Please check the link to make sure that it is actually working and points
> +to the relevant message.
> +
> +However, try to make your explanation understandable without external
> +resources.  In addition to giving a URL to a mailing list archive or
> +bug, summarize the relevant points of the discussion that led to the
> +patch as submitted.
> +
>  If your patch fixes a bug in a specific commit, e.g. you found an issue using
>  ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>  the SHA-1 ID, and the one line summary.  Do not split the tag across multiple

-- 
Jani Nikula, Intel Open Source Graphics Center
