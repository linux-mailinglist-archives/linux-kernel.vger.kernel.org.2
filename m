Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217E4320CA2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhBUSgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBUSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:36:23 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF9BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 10:35:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a22so51727792ljp.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 10:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxqy2QaM0H7zKuChLvrzb4hgaQQEMjeZnvyVRfd9I1o=;
        b=GBRdczyy0sPWHm91ezLPqpJRcQlHLvOqC8LCjTQhUHzRB+wzrdW5of5bkX7OLUpgDe
         irDwU7OjZ/0wGxpeTNF6FlIqXpf1uMl/POHHKjfVwz6MG1CSVXlCpEqHTHBwxolrb3al
         yVp6HvIQW7DLHIMZtaOwjWzKKtzB05rNI1lUY5XEOR7yarPHjP82DEvAco16mMdc4wLO
         HKGnXaf3zVB+IBnzE4v1l/hM5n3BKMfw8biYsbXCkdgrM7LqNVUDzIJ8VQY2ygTgxb1X
         3y5rMAZ+J8uGxMEHkxQP5mrru41eRqKMvLO/vKAZUQD7EeTHjdpwCByaybJZpG5JPBtG
         sqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxqy2QaM0H7zKuChLvrzb4hgaQQEMjeZnvyVRfd9I1o=;
        b=pi2/6BQJhb+Nyhdhym2NhRHs83GdwDdsOVFGxrsRFojUUPXBhyU17gc61l815rfFhq
         Lr9iIEI86ff/acza+JtPXluV75E+MRTgQwlI0vBgv6aStCjnVy4Q2Bc5QCkKrY6g8Mrr
         /O0sZh4VV4CPy4XEJBaLy2oaDqs9VsDQSTqpgT7TC3O7zhfIiqsxGu6xIu8aiOR/9Z4j
         6S7KGGVVSgO2J1uU0bVHzAHtrIv9gSajFjCgm8kE+VnFEloYT79qehZgSiyspkCr7sXf
         ODnbVLk4MMkTeBwR+MD+rwc7A+PL5ic4L4g0HRma0vxdI8ceZQoSWslFIyB7lO8l16Qe
         j4Cw==
X-Gm-Message-State: AOAM533LjAItOAlG+uLiCcYxZH8JkB587RMeB/tFUaBYwzVII0wfPm7W
        LI9YirGjda8ljSLefU0Ao8Bm62+cgY+1Jmi0PWY=
X-Google-Smtp-Source: ABdhPJzDLi7vHID87eLisqTtrtAoyZILR4cMH/xqtP0Pdr9p/t4A1/0/kjdYShz1ib/0ZK7utaYWQOo2RAUmyap7O0w=
X-Received: by 2002:a2e:9841:: with SMTP id e1mr2207442ljj.373.1613932541079;
 Sun, 21 Feb 2021 10:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20210221115802.19788-1-dwaipayanray1@gmail.com>
 <20210221115802.19788-2-dwaipayanray1@gmail.com> <46c3b16602f36858b194b22dfbdb2150e25f5d94.camel@perches.com>
In-Reply-To: <46c3b16602f36858b194b22dfbdb2150e25f5d94.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 22 Feb 2021 00:05:40 +0530
Message-ID: <CABJPP5CJKUeaxUqKzuJD5pd2HsHKcAx9x3iCm6W+Z8AuXiR5Rg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] checkpatch: add verbose mode
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 11:36 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2021-02-21 at 17:28 +0530, Dwaipayan Ray wrote:
> > Add a new verbose mode to checkpatch.pl to emit additional verbose
> > test descriptions. The verbose mode is optional and can be enabled
> > by the flag -v or --verbose.
>
> OK, maybe add color coding to the list_types output.

Okay, nice idea!
> Something like:
> ---
>  scripts/checkpatch.pl | 61 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bbff13e0ca7e..ccd4a1bd73cb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -163,14 +163,39 @@ sub list_types {
>         my $text = <$script>;
>         close($script);
>
> -       my @types = ();
> +       my %types = ();
>         # Also catch when type or level is passed through a variable
> -       for ($text =~ /(?:(?:\bCHK|\bWARN|\bERROR|&\{\$msg_level})\s*\(|\$msg_type\s*=)\s*"([^"]+)"/g) {
> -               push (@types, $_);
> +       while ($text =~ /\b(CHK|WARN|ERROR|&\{\$msg_level})\s*\(\s*"([^"]+)"/g) {
> +               if (exists($types{$2})) {
> +                       $types{$2} .= ",$1" if ($types{$2} ne $1);
> +               } else {
> +                       $types{$2} = $1;
> +               }
> +       }
> +       print("#\tMessage type");
> +       if ($color) {
> +               print(" (color coding: ");
> +               print(RED . "ERROR" . RESET);
> +               print("|");
> +               print(YELLOW . "WARNING" . RESET);
> +               print("|");
> +               print(GREEN . "CHECK" . RESET);
> +               print("|");
> +               print("Multiple levels" . RESET);
> +               print(")");
>         }
> -       @types = sort(uniq(@types));
> -       print("#\tMessage type\n\n");
> -       foreach my $type (@types) {
> +       print("\n\n");
> +       foreach my $type (sort keys %types) {
> +               if ($color) {
> +                       my $level = $types{$type};
> +                       if ($level eq 'ERROR') {
> +                               $type = RED . $type . RESET;
> +                       } elsif ($level eq 'WARN') {
> +                               $type = YELLOW . $type . RESET;
> +                       } elsif ($level eq 'CHK') {
> +                               $type = GREEN . $type . RESET;
> +                       }
> +               }
>                 print(++$count . "\t" . $type . "\n");
>                 if ($verbose && exists($verbose_messages{$type})) {
>                         my $message = $verbose_messages{$type};
> @@ -301,6 +326,18 @@ help(0) if ($help);
>  die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
>  die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
>
> +if ($color =~ /^[01]$/) {
> +       $color = !$color;
> +} elsif ($color =~ /^always$/i) {
> +       $color = 1;
> +} elsif ($color =~ /^never$/i) {
> +       $color = 0;
> +} elsif ($color =~ /^auto$/i) {
> +       $color = (-t STDOUT);
> +} else {
> +       die "$P: Invalid color mode: $color\n";
> +}
> +
>  load_docs() if ($verbose);
>  list_types(0) if ($list_types);
>
> @@ -321,18 +358,6 @@ if ($#ARGV < 0) {
>         push(@ARGV, '-');
>  }
>
> -if ($color =~ /^[01]$/) {
> -       $color = !$color;
> -} elsif ($color =~ /^always$/i) {
> -       $color = 1;
> -} elsif ($color =~ /^never$/i) {
> -       $color = 0;
> -} elsif ($color =~ /^auto$/i) {
> -       $color = (-t STDOUT);
> -} else {
> -       die "$P: Invalid color mode: $color\n";
> -}
> -
>  # skip TAB size 1 to avoid additional checks on $tabsize - 1
>  die "$P: Invalid TAB size: $tabsize\n" if ($tabsize < 2);
>
>

Sure, I will do something like this.
Are there any other improvements you can see right now
or will the coloring thing suffice?

Thanks,
Dwaipayan
