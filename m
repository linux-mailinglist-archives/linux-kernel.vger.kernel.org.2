Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3398C332756
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCINij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:38:39 -0500
Received: from smtp1.goneo.de ([85.220.129.30]:55954 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbhCINiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:38:20 -0500
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 08:38:19 EST
Received: from [192.168.1.127] (dyndsl-085-016-044-246.ewe-ip-backbone.de [85.16.44.246])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 5F1452038178;
        Tue,  9 Mar 2021 14:30:48 +0100 (CET)
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Aditya Srivastava <yashsri421@gmail.com>, corbet@lwn.net
Cc:     lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210309125324.4456-1-yashsri421@gmail.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
Date:   Tue, 9 Mar 2021 14:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309125324.4456-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 09.03.21 um 13:53 schrieb Aditya Srivastava:
> Starting commented lines in a file mostly contains comments describing
> license, copyright or general information about the file.
> 
> E.g., in sound/pci/ctxfi/ctresource.c, initial comment lines describe
> its copyright and other related file informations.

The opening comment mark /** is used for kernel-doc comments [1]

[1] 
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments

   -- Markus --

> 
> But as kernel-doc reads these lines, it results in ineffective warnings by
> kernel-doc, related to these.
> 
> Provide a simple fix by skipping first three lines in a file for checking
> kernel-doc comments.
> 
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>   scripts/kernel-doc | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index e1e562b2e2e7..431add05248e 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -2375,6 +2375,7 @@ sub process_file($) {
>       my $file;
>       my $initial_section_counter = $section_counter;
>       my ($orig_file) = @_;
> +    my $lineno = 0;	# to maintain the count of line number in a file
>   
>       $file = map_filename($orig_file);
>   
> @@ -2388,13 +2389,16 @@ sub process_file($) {
>   
>       $section_counter = 0;
>       while (<IN_FILE>) {
> +	$lineno++;
>   	while (s/\\\s*$//) {
>   	    $_ .= <IN_FILE>;
> +	    $lineno++;
>   	}
>   	# Replace tabs by spaces
>           while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
>   	# Hand this line to the appropriate state handler
> -	if ($state == STATE_NORMAL) {
> +	if ($state == STATE_NORMAL
> +	    && $lineno > 3) {	# to avoid starting comment lines describing the file
>   	    process_normal();
>   	} elsif ($state == STATE_NAME) {
>   	    process_name($file, $_);
> 
