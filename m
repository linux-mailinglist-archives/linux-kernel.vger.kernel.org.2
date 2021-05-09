Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB33777AE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEIRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 13:03:45 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:58428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229924AbhEIRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 13:03:44 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A6CB718029D82;
        Sun,  9 May 2021 17:02:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 1BC3E1D42F4;
        Sun,  9 May 2021 17:02:40 +0000 (UTC)
Message-ID: <6be9a194814f8fd113f4967d80c19f861b908356.camel@perches.com>
Subject: Re: Codespell dictionary path is no longer absolute
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 09 May 2021 10:02:38 -0700
In-Reply-To: <CABJPP5BExfW+xre-3E-9EysYMhLGRzNrkPbTW3qomOKqc31PSQ@mail.gmail.com>
References: <CABJPP5BExfW+xre-3E-9EysYMhLGRzNrkPbTW3qomOKqc31PSQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1BC3E1D42F4
X-Spam-Status: No, score=-2.84
X-Stat-Signature: g98wcsokpwo5qzyjqnn1ybyz9zxfekb1
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19+Tw4/r2/KfN9DDHloOYVYMG0z5wRA5Qo=
X-HE-Tag: 1620579759-821716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-05-09 at 21:12 +0530, Dwaipayan Ray wrote:
> A year ago, the codespell dictionary was moved from
> /usr/share/codespell/dictionary.txt to data/dictionary.txt under
> the codespell_lib installation directory.
> 
> checkpatch.pl still has the default codespell path as
> /usr/share/codespell/dictionary.txt.
> Any new installations will now also need to specify --codespellfile
> option along with --codespell.
> 
> Can auto detection of the dictionary path be enabled with something
> like this?
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -889,6 +889,9 @@ if (open(my $spelling, '<', $spelling_file)) {
> }
> 
> if ($codespell) {
> +       if (! -e "$codespellfile" && which("python") ne "") {
> +               $codespellfile = `python -c "import os.path as op; import code
> spell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictiona
> ry.txt'), end='')"`;
> +       }

Maybe, but it doesn't work with python2

And it's likely better to do as few things in python as possible
so maybe ditch the op.join and use perl instead

	if (! -e "$codespellfile" && which("python") ne "" &&
	    `python -c "import sys; print(sys.version_info.major)"` >= "3") {
		$codespellfile = dirname(`python -c "import codespell_lib; print(codespell_lib.__file__);"`) . "/data/dictionary.txt";
	}


