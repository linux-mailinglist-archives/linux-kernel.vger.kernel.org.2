Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052383E0E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhHEGSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:18:42 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:35756
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236825AbhHEGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:17:57 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id ABE0340643
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628144262;
        bh=/l4qpCPQmBoC8kqZhVgLt1Wh0qZICy0rU+2tYIrhr84=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Ge2rKVXd0qYV5HJ1ALnKq4cEOjYgaUN5mqLPcNsmU+ZvN2gikFD7ESf+MFFVaPQ8v
         OmMt5QZR3FfaVgQVvQySi7bbkzy+fUQy9DGPaj24wkVa6ocRcBMN3/iLZlIm3sng0C
         8ms52+r3FNrr1yaEAdN+OIIpkgRElZbIBdEkPEDZl0qCmC+EaZ0WypuCZh09JKbPzL
         FNbemjVUheQPjkU8A/TFllMd2kkPDbqkp3mTvDa6n/0hGZ5oZifHud3ni85GYhrR7g
         mq5aqjz+MwKU8qqp+zfUhtPwKrzKu+FjjDbC4Y8lQiGNL8x3kD/ZuuyAO+iXuV2hqH
         iIK04gGx+JJ1g==
Received: by mail-ed1-f71.google.com with SMTP id y22-20020a0564023596b02903bd9452ad5cso2608829edc.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 23:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/l4qpCPQmBoC8kqZhVgLt1Wh0qZICy0rU+2tYIrhr84=;
        b=AyOoLrVXHKqRNbvrkk/LToORa6st8lZWIsKTtns9DOLZYnYJf/D7z4EWV5+VP6i2jJ
         ymg/PvuI5t2jc1wsahiziQWqTLg2v35Fk8odbfyLZU7a/6lr1dlfX/aAPU7vNjKu62KL
         ApuLYhhw4BgqxNUw749LMXhJJ2tw7VlijikBz4aOHrTQQ1tOOw5Hru2VuahNibMhkaoF
         Mtleush6bw5ShQzHSAr7rPTwVhyUUYCipT2l9N3/UUDU9rhMewcH4nuHXRlf1DYngakj
         2k4GiTjREjkrkGueKrJsFY4rnYUfePy0YV68o6bCAYmZRIi2zBRyW9xJzput5UUvkzTd
         Nmlw==
X-Gm-Message-State: AOAM531ZugxCIRUULa8BxUiKvzEARSf7o/1OrypPDIVlU5RS3jMpjEr9
        qrlmheXb2LFO2Oyf5sRI00qT7CukQI/LWgaf0gRMZI4gUdz/Nsxh8k2TLlKVo6LzVdfLHUcGtGe
        DLFGLjjHMWSjr6PNolx0UVV+zC5EP2CnalAsF03GEoVcL7P1hfMsyJnznxg==
X-Received: by 2002:a17:907:9d2:: with SMTP id bx18mr3154776ejc.117.1628144262358;
        Wed, 04 Aug 2021 23:17:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygNacTUbcuFV81B08v/ncs8QieT7alT4MAVBYt9dyBZbLuB4azxH4DJ6P2ce3YEApHx7shyEeirvVFH5uj+/o=
X-Received: by 2002:a17:907:9d2:: with SMTP id bx18mr3154762ejc.117.1628144262115;
 Wed, 04 Aug 2021 23:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160949.592227-1-kai.heng.feng@canonical.com> <2d594d0b06401887debd5ec462edcffdc813318a.camel@perches.com>
In-Reply-To: <2d594d0b06401887debd5ec462edcffdc813318a.camel@perches.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 5 Aug 2021 14:17:26 +0800
Message-ID: <CAAd53p4dXVkuBXShCesEQkPi52CuaVm3tRBnD4S13saLdEGsRQ@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: Append parenthesis back to trimmed
 subsystem name
To:     Joe Perches <joe@perches.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 12:22 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2021-08-05 at 00:09 +0800, Kai-Heng Feng wrote:
> > When a closing parenthesis gets trimmed, there can be unmatched
> > parenthesis in the subsystem name. This doesn't play well with
> > git-send-email:
> > (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...) from: 'scripts/get_maintainer.pl'
> > Unmatched () '(open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)' '' at /usr/lib/git-core/git-send-email line 554.
> > error: unable to extract a valid address from: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)
> >
> > So append parenthesis back if it was trimmed to make git-send-email
> > work again:
> > (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Mooresto...)) from: 'scripts/get_maintainer.pl'
>
> Probably better just to add --norolestats to the invoking command-line.

This can solve the issue beautifully, thanks!

>
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> []
> > @@ -1252,9 +1252,10 @@ sub get_subsystem_name {
> >
> >
> >      my $subsystem = $typevalue[$start];
> >      if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
> > -     $subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
> > +     my $parenthesis = substr($subsystem, -1) eq ")";
> > +     $subsystem = substr($subsystem, 0, $output_section_maxlen - ($parenthesis ? 4 : 3));
> >       $subsystem =~ s/\s*$//;
> > -     $subsystem = $subsystem . "...";
> > +     $subsystem = $subsystem . "..." . ($parenthesis ? ")" : "");
>
> Given an $output_section_maxlen number of possible parentheses, this should
> probably use a while...

Or maybe count the parentheses in two runs?

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8e..08315074acffa 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1252,9 +1252,21 @@ sub get_subsystem_name {

     my $subsystem = $typevalue[$start];
     if ($output_section_maxlen && length($subsystem) >
$output_section_maxlen) {
+       my $need_closing = 0;
        $subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
        $subsystem =~ s/\s*$//;
-       $subsystem = $subsystem . "...";
+
+       if (substr($subsystem, -1) eq "(") {
+           $subsystem = substr($subsystem, 0, -2);
+       } else {
+           my $opening = () = $subsystem =~ /\(/g;
+           my $closing = () = $subsystem =~ /\)/g;
+           if ($opening != $closing) {
+               $need_closing = 1;
+           }
+       }
+
+       $subsystem = $subsystem . "..." . ($need_closing ? ")" : "");
     }
     return $subsystem;

>
>
