Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DC335E9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 01:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348812AbhDMX15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 19:27:57 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:26246 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhDMX1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 19:27:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 13C0AA38;
        Wed, 14 Apr 2021 01:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=dkim20160331; t=
        1618356449; x=1620170850; bh=eLf25vYXZExxa3WxKUbXJtp107ajvzcDXk7
        MFsei6WA=; b=GXej5pwiOJWUlAVJdzyozEUA9KG9vtCTd9UsQllETSSB86xJ14Q
        tFmDWQAtYng9P/dc6wiR/g5bm/6gwCMZNdreT5al9iHcE2c82aADojuNQjB2Bewo
        mblJ8sjGAOif6iuo3th7Ji2aTpoVsXzIMvPcv5/zWOZTefrswT2YT10IAZtqpjjd
        a8nO1U6/VMbTcsrEzD1IxBkOMFgYHWIy71RPZW3nG20nknOROH/rUca4c9c/VJn8
        9ey2FpQgb5KvBw/++fK45uZTLIArzj+vbMhJOlyYfBpD0I/Iv3DYN3nZo9Y5sCNz
        Rn6xnF3hKLiypo8BWA3TpaOmmXGatnFeWlUH7llohPYmItmgO0ctcv0zKq/p55aH
        wSI1QnMwEOiB/sEtmVAlUDFltdhJ4k4cwVcvg2YFEa7o70ghjPMG3bcrAzY9qNa0
        7tTsGdWlxPPYuFlmox9aUWyjRVS3sbE/3zM+AcOMgstTG+5V5F7KiO53EYndnTD/
        04oKBnPedUaL2ouXBd8cbTdLJj6WCmNeP6ctSp2N4icnxK3Ja/LB49FZi7GD5UfL
        GnicBqofz76LASlS1id3qoLnFiYiOaC6rJzNM4NDpJKMq7Bkw0oX4vuSLGCGqeqS
        f8EKZiVgFGU6Gc83abBU8Zpx+1XYOMIUmk0mgCMcuWbxGVCkt15l/oOo=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RwaDGGNmyOLk; Wed, 14 Apr 2021 01:27:29 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 203FD891;
        Wed, 14 Apr 2021 01:27:28 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 30BBE351;
        Wed, 14 Apr 2021 01:27:26 +0200 (CEST)
Date:   Wed, 14 Apr 2021 01:27:23 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Wu XiangCheng <bobwxc@email.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] Add a new translation tool scripts/trslt.py
Message-ID: <20210413232722.lzbex2cwifdd5cm2@numero86.vaga.pv.it>
References: <cover.1618208899.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1618208899.git.bobwxc@email.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yes, you are touching a good point where things can be improved. I admit that I
did not have a look at the code yet, if not very quickly. Perhaps I'm missing
somethin. However, let me give you my two cents based on what I usually do.

I do not like the idea of adding tags to the file and having tools to modify it.
I would prefer to keep the text as clean as possible.

Instead, what can be done without touching manipulating the text file is to do
something like this:

# Take the commit ID of the last time a document has translated
LAST_TRANS=$(git log -n 1 --oneline Documentation/translations/<lang>/<path-to-file> | cut -d " " -f 1)

# Take the history of the same file in the main Documentation tree
git log --oneline $LAST_TRANS..doc/docs-next Documentation/<path-to-file>

This will give you the list of commits that changed <path-to-file>, and that
probably need to be translated. The problem of this approach is that by the time
you submit a translation, other people may change the very same files. The
correctness of this approach depends on patch order in docs-next, and this can't
be guaranteed.

So, instead of reling on LAST_DIR, I rely on a special git branch that acts as
marker. But this works only for me and not for other translator of the same
languages, so you can get troubles also in this case.

What we can actually do is to exploit the git commit message to store the tag
you mentioned. Hence, we can get the last Id with something like this:

LAST_ID=$(git log -n 1 Documentation/translations/<lang>/<path-to-file> | grep -E "Translated-on-top-of: commit [0-9a-f]{12}")

The ID we store in the tag does not need to be the commit ID of the last change
to <path-to-file>, but just the commit on which you were when you did the
translation. This because it will simplify the management of this tag when
translating multiple files/patches in a single patch (to avoid to spam the
mailing list with dozens of small patches).

On Mon, Apr 12, 2021 at 03:04:03PM +0800, Wu XiangCheng wrote:
>Hi all,
>
>This set of patches aim to add a new translation tool - trslt.py, which
>can control the transltions version corresponding to source files.
>
>For a long time, kernel documentation translations lacks a way to control the
>version corresponding to the source files. If you translate a file and then
>someone updates the source file, there will be a problem. It's hard to know
>which version the existing translation corresponds to, and even harder to sync
>them.
>
>The common way now is to check the date, but this is not exactly accurate,
>especially for documents that are often updated. And some translators write
>corresponding commit ID in the commit log for reference, it is a good way,
>but still a little troublesome.
>
>Thus, the purpose of ``trslt.py`` is to add a new annotating tag to the file
>to indicate corresponding version of the source file::
>
>.. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>
>The script will automatically copy file and generate tag when creating new
>translation, and give update suggestions based on those tags when updating
>translations.
>
>More details please read doc in [Patch 2/2].
>
>Still need working:
>- improve verbose mode
>- test on more python 3.x version
>- only support linux now, need test on Mac OS, nonsupport Windows
>  due to '\'
>
>Any suggestion is welcome!
>
>Thanks!
>
>Wu XiangCheng (2):
>  scripts: Add new translation tool trslt.py
>  docs: doc-guide: Add document for scripts/trslt.py
>
> Documentation/doc-guide/index.rst |   1 +
> Documentation/doc-guide/trslt.rst | 233 ++++++++++++++++++++++++++
> scripts/trslt.py                  | 267 ++++++++++++++++++++++++++++++
> 3 files changed, 501 insertions(+)
> create mode 100644 Documentation/doc-guide/trslt.rst
> create mode 100755 scripts/trslt.py
>
>-- 
>2.20.1
>


