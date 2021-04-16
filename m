Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D378361C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbhDPIpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:45:46 -0400
Received: from [43.250.32.171] ([43.250.32.171]:40256 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S237554AbhDPIpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=uFVmYyJsv7zFrvijHof2lvoAkPiFvLiawcXwY
        AI6kAA=; b=FUeeWTdU7/CWn3Kona9Ud3LcyZSK4rlMp2MEkU89LecEPLuT2wlsY
        DuK1HO8ifshLCdqk2QK6nWt1gt/Q7g70KYM7MyLg5fZohxdGfAs8eNik43t80wTz
        naoC111K7InzUi4HbHmP4InMloR2dh/U09Nq6Vxsv/RPmSlx+TzfBA=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgC3KtGNTnlgDu9fAA--.22101S2;
        Fri, 16 Apr 2021 16:45:02 +0800 (CST)
Date:   Fri, 16 Apr 2021 16:45:00 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] Add a new translation tool scripts/trslt.py
Message-ID: <20210416084500.GA7344@bobwxc.top>
References: <cover.1618208899.git.bobwxc@email.cn>
 <20210413232722.lzbex2cwifdd5cm2@numero86.vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210413232722.lzbex2cwifdd5cm2@numero86.vaga.pv.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgC3KtGNTnlgDu9fAA--.22101S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWxtrWUXry8GF4UKFWUtwb_yoW7Jw45pF
        WUG3ZxKF4Dtr12yr1fCr4UWF1Fy3Z7Kr45JFy2qrn3ArZ8tr92qFW3K3yY9F9rJryvva4j
        vr4jkrWUuFs8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgIb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY02Avz4vE14v_GFyl42xK82
        IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x07jX9N3UUUUU=
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Federico,

On Wed, Apr 14, 2021 at 01:27:23AM +0200, Federico Vaga wrote:
> Hi,
> 
> Yes, you are touching a good point where things can be improved. I admit that I
> did not have a look at the code yet, if not very quickly. Perhaps I'm missing
> something. However, let me give you my two cents based on what I usually do.
> 
> I do not like the idea of adding tags to the file and having tools to modify it.
> I would prefer to keep the text as clean as possible.

Yeah, I also consider about that, so let this tag be one line and a comment 
at design time, hope make text clean.

> 
> Instead, what can be done without touching manipulating the text file is to do
> something like this:
> 
> # Take the commit ID of the last time a document has translated
> LAST_TRANS=$(git log -n 1 --oneline Documentation/translations/<lang>/<path-to-file> | cut -d " " -f 1)
> 
> # Take the history of the same file in the main Documentation tree
> git log --oneline $LAST_TRANS..doc/docs-next Documentation/<path-to-file>
> 
> This will give you the list of commits that changed <path-to-file>, and that
> probably need to be translated. The problem of this approach is that by the time
> you submit a translation, other people may change the very same files. The
> correctness of this approach depends on patch order in docs-next, and this can't
> be guaranteed.

Thanks for sharing your experiences!

Yes, the order is why I think about this translation version control.
It's really messy especially when file be updated frequently.
And some old files are also hard to maintain.

> 
> So, instead of relying on LAST_DIR, I rely on a special git branch that acts as
> marker. But this works only for me and not for other translator of the same
> languages, so you can get troubles also in this case.
> 
> What we can actually do is to exploit the git commit message to store the tag
> you mentioned. Hence, we can get the last Id with something like this:
> 
> LAST_ID=$(git log -n 1 Documentation/translations/<lang>/<path-to-file> | grep -E "Translated-on-top-of: commit [0-9a-f]{12}")
> 
> The ID we store in the tag does not need to be the commit ID of the last change
> to <path-to-file>, but just the commit on which you were when you did the
> translation. This because it will simplify the management of this tag when
> translating multiple files/patches in a single patch (to avoid to spam the
> mailing list with dozens of small patches).

Yes, I also think about store the relative commit-id in commit message.
Being a git-hook is easy for now, but if we'd like to add something in
the future, it would may need add another script. Or just a tool which
show the relative information and let translator add it by themselves?

But to be honest, I'd like to make the tool could have more functions in
the future. Like auto start worlflow etc. More and more people will
join the translation work and some new developers also start their way
from here. There is a clear need to make the work more standardized and
easier.

Thanks!

Wu X.C.

> 
> On Mon, Apr 12, 2021 at 03:04:03PM +0800, Wu XiangCheng wrote:
> > Hi all,
> > 
> > This set of patches aim to add a new translation tool - trslt.py, which
> > can control the transltions version corresponding to source files.
> > 
> > For a long time, kernel documentation translations lacks a way to control the
> > version corresponding to the source files. If you translate a file and then
> > someone updates the source file, there will be a problem. It's hard to know
> > which version the existing translation corresponds to, and even harder to sync
> > them.
> > 
> > The common way now is to check the date, but this is not exactly accurate,
> > especially for documents that are often updated. And some translators write
> > corresponding commit ID in the commit log for reference, it is a good way,
> > but still a little troublesome.
> > 
> > Thus, the purpose of ``trslt.py`` is to add a new annotating tag to the file
> > to indicate corresponding version of the source file::
> > 
> > .. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
> > 
> > The script will automatically copy file and generate tag when creating new
> > translation, and give update suggestions based on those tags when updating
> > translations.
> > 
> > More details please read doc in [Patch 2/2].
> > 
> > Still need working:
> > - improve verbose mode
> > - test on more python 3.x version
> > - only support linux now, need test on Mac OS, nonsupport Windows
> >  due to '\'
> > 
> > Any suggestion is welcome!
> > 
> > Thanks!
> > 
> > Wu XiangCheng (2):
> >  scripts: Add new translation tool trslt.py
> >  docs: doc-guide: Add document for scripts/trslt.py
> > 
> > Documentation/doc-guide/index.rst |   1 +
> > Documentation/doc-guide/trslt.rst | 233 ++++++++++++++++++++++++++
> > scripts/trslt.py                  | 267 ++++++++++++++++++++++++++++++
> > 3 files changed, 501 insertions(+)
> > create mode 100644 Documentation/doc-guide/trslt.rst
> > create mode 100755 scripts/trslt.py
> > 
> > -- 
> > 2.20.1
> > 
> 

