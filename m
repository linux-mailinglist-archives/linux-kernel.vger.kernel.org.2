Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7965F4294CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhJKQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:52:58 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:33112 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229816AbhJKQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:52:56 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D2905837F27E;
        Mon, 11 Oct 2021 16:50:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id E2F04C4190;
        Mon, 11 Oct 2021 16:50:54 +0000 (UTC)
Message-ID: <510f7db524904e2f87fe4d52018f712e2df3b7bc.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: get default codespell dictionary path
 from package location
From:   Joe Perches <joe@perches.com>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Oct 2021 09:50:53 -0700
In-Reply-To: <20211011114952.26145-1-peter.ujfalusi@linux.intel.com>
References: <20211011114952.26145-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.60
X-Stat-Signature: e3tytwfqwwysn614wks7ats48jkykjwx
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E2F04C4190
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+C7O3lW9EYEK/nsrd4geLk3eFCycocMFc=
X-HE-Tag: 1633971054-828315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-11 at 14:49 +0300, Peter Ujfalusi wrote:
> The standard location of dictionary.txt is under codespell's package, on
> my machine atm (codespell 2.1, Artix Linux):
> /usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt
> 
> Since we enable the codespell by default for SOF I have constant:
> No codespell typos will be found - \
> file '/usr/share/codespell/dictionary.txt': No such file or directory
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +	# Try to find the codespell install location to use it as default path
> +	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
> +		my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
> +		$codespellfile = $codespell_dict if (-e $codespell_dict);
> +	}

This is really hard to read.

Can this be written something like

my $python_codespell_dict = << "EOF"
import os.path as op
import codespell_lib
codespell_dir = op.dirname(codespell_lib.__file__)
codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
print(codespell_file)
EOF
;
my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;


