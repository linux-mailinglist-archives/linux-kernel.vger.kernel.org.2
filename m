Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40C37961F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhEJRkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:40:15 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:37000 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230507AbhEJRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:40:13 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 52048837F27B;
        Mon, 10 May 2021 17:39:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 9B5FC315D82;
        Mon, 10 May 2021 17:39:06 +0000 (UTC)
Message-ID: <630fc44bfb88f8d3d542c084c2d9f7c0a6d8aea7.camel@perches.com>
Subject: Re: [PATCH] checkpatch: auto detect codespell dictionary path
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Mon, 10 May 2021 10:39:05 -0700
In-Reply-To: <20210510171127.15056-1-dwaipayanray1@gmail.com>
References: <20210510171127.15056-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.87
X-Stat-Signature: m7kffn3zzbpqdc8wza5mbk5gy45z836s
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9B5FC315D82
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18lb2+7QkLKJXxM0h5ZWEvgHf9j5olsgQw=
X-HE-Tag: 1620668346-785097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-10 at 22:41 +0530, Dwaipayan Ray wrote:
> The codespell dictionary was moved from
> `/usr/share/codespell/dictionary.txt` to data/dictionary.txt
> under the codespell_lib installation directory.
> 
> Checkpatch still uses a default absolute path for it which will
> no longer work on new codespell installations unless the path
> is specified through --codespellfile.
> 
> Detect the codespell dictionary path dynamically during
> runtime if the default path or the user provided dictionary
> path does not exist.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -889,6 +889,13 @@ if (open(my $spelling, '<', $spelling_file)) {
>  }
>  
> 
>  if ($codespell) {
> +	if (! -e "$codespellfile" && which("python3") ne "") {
> +		my $output = `python3 -c "import codespell_lib; print(codespell_lib.__file__, end='');" 2>/dev/null`;

It doesn't seem to me that using python3 is a great way to invoke python.
Maybe test the external command return $? when codespell isn't installed.

> +		my $dictionary_path = dirname($output) . "/data/dictionary.txt";

Unlikely, but this could still end up with a existing file of /data/dictionary.txt
that is not a codespell file.

> +		if (-e "$dictionary_path") {
> +			$codespellfile = $dictionary_path;
> +		}
> +	}
>  	if (open(my $spelling, '<', $codespellfile)) {
>  		while (<$spelling>) {
>  			my $line = $_;


