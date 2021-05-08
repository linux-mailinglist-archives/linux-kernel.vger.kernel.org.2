Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF92376E16
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 03:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhEHBbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:31:43 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:39520 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHBbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:31:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4FcVBS4n3Tz9vCBT
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 01:30:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PFcvIHKTMtIb for <linux-kernel@vger.kernel.org>;
        Fri,  7 May 2021 20:30:39 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4FcVBR5Bgmz9vCBB
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 20:30:39 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4FcVBR5Bgmz9vCBB
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4FcVBR5Bgmz9vCBB
Received: by mail-io1-f70.google.com with SMTP id b3-20020a0566020003b0290438e38269adso1746153ioa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pk46umjNzlw89+9z5OQjxhLsXxSejf+roT0Kz4X6oM0=;
        b=TIxH50sjpunax7htcEoaBX2pgMAD08nkwws6x8P0CxN5kVEIWpXdlkteFNjZWRbfV9
         UJj0munZhW2IAlcfpPAHIF9jjPDzZrDkjRxnDhqtpqWLBrwDx9wsWFX7qSucV0XTIDFJ
         vbDI5i9yvkHcQZHXshv7niVLyARNoKRKmxQDuXzRHuvHcJwdjUYqtqNZYDwnToz6GlML
         n+4onCqQI+hlaaBuCS/AaCwf0Y5IHgDVXobR6TsweXdf1dnsKXgJFRxQM70cozREnZcj
         i67gIuQ3/IiZN1j5iWoNE1bPr/idXMvGMqriZFyDzzY2Bxre8IVhOwn2DlcbAf9rz30d
         X+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pk46umjNzlw89+9z5OQjxhLsXxSejf+roT0Kz4X6oM0=;
        b=mGN7UYvBtkcCj1ZGXQKh3yU9tTMmSWy/ifTPT57bwqY5PGQmQrbGRSrGS3TI1M+GGf
         8/L28TSPyimKnZSIBzEAWbptfUvB5XtR10CP6wBXvj+png9AuTBQT12tkypyQ8uRT2PK
         rGkvSu55jrGuZmGm9Gp8iCNGZmJMzyrkw9T1I/bVWr84qpAZ6utxIonz/8801y7F6LFI
         opLNDAYVr4m5iODiSwcrdxAvzx6if6x2EtMYM7bfOXcan4EBGI+S53BBm5bQmVpEGMHj
         9Eh/R6Ll5HxV/fwAS7VQrTbTufRSOzlET8Xtyv24R/4bf4s5cxpNylp0m+dzhozwKL4f
         MhKw==
X-Gm-Message-State: AOAM530p/GXleaf+SQVY5X2bgbM44rQNKLFEKfpNogIZI7ezU9vRSCyo
        gr7Uimn98GG64RzUwgYqXyiy6KbTi9Xa+31TMrqrl6dP+MBnU8rOBypET4x5MEFQTjYNKa8TCht
        +Sy3auJHj1GI3Unz37ED/5C5Uv4glnIn36wpV/g7G1ooJ
X-Received: by 2002:a05:6638:2591:: with SMTP id s17mr11181691jat.87.1620437435641;
        Fri, 07 May 2021 18:30:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkxukt/Ymsnrd+2IiUveG84dyoP1gWy8ho74mjdFHgF2qmYv4mJq32Z+9AymBMNknmQ8Vm16lT+jMLQ0ebi6A=
X-Received: by 2002:a05:6638:2591:: with SMTP id s17mr11181538jat.87.1620437432466;
 Fri, 07 May 2021 18:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <202105051005.49BFABCE@keescook>
In-Reply-To: <202105051005.49BFABCE@keescook>
From:   Kangjie Lu <kjlu@umn.edu>
Date:   Fri, 7 May 2021 20:30:21 -0500
Message-ID: <CAK8Kejr8bggXruciJT=JW3mk2z=WxYrtN+HBouPq4E2FU=6GrQ@mail.gmail.com>
Subject: Re: Report on University of Minnesota Breach-of-Trust Incident
To:     Kees Cook <keescook@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        tech-board@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statement from UMN Computer Science & Engineering: Confirming Linux
Technical Advisory Board Findings

We again extend our apologies to the Linux Kernel Community for the
concerns and extra work caused by our inappropriately designed
"hypocrite commits" project. We also want to express our appreciation
for the thoughtful report released by the Linux Technical Advisory
Board (TAB)  on May 5, 2021
(https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/ ), and
the willingness of the Linux Foundation to meet with us on May 6,
2021.

The University of Minnesota team has reviewed the TAB findings and
want to confirm that the findings are comprehensive with an exception
discussed below.

One email address missing is a visiting student in the team who used
the account =E2=80=9CWenjia Zhao <driverfuzzing@gmail.com>=E2=80=9D to send=
 four
patches for bugs found by a tool:
https://lore.kernel.org/patchwork/project/lkml/list/?series=3D&submitter=3D=
29945&state=3D*&q=3D&archive=3Dboth&delegate=3D.
None of those patches were accepted or merged.

All Minnesota patches submitted before August 9, 2020 were part of
previous bug-finding research projects and submitted in good faith and
intended to address bugs in the Linux Kernel. The four patches
submitted between August 9, 2020  and August 21, 2020 were part of our
ill-conceived =E2=80=9Chypocrite commit=E2=80=9D case-study. They are the o=
nly patches
of this nature ever submitted from Minnesota and they were stopped
before making it past the review stage. The five patches submitted on
April 6, 2021 were part of a subsequent project and also submitted in
good faith (although superfluous and considered to be of poor
quality).

Furthermore, we want to state unequivocally that no other Linux
components or any other open software systems were affected by the
'hypocrite commits' case study or by any of our other research
projects. Our =E2=80=9Chypocrite commit=E2=80=9D work was limited to the Li=
nux Kernel
only and consisted of only the four patches (one is valid) submitted
between August 9, 2020 and August 21, 2020.

We reiterate our apology, and we rededicate ourselves to educating our
faculty and students in conducting research that is not only of the
highest technical quality, but also follows the highest ethical
standards.

On Wed, May 5, 2021 at 12:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> Report on University of Minnesota Breach-of-Trust Incident
>
>         or
>
> "An emergency re-review of kernel commits authored by members of the
>  University of Minnesota, due to the Hypocrite Commits research paper."
>
> May 5, 2021
>
> Prepared by the Linux Foundation's Technical Advisory Board
>         <tech-board@lists.linux-foundation.org>
>         Chris Mason (chair)
>         Steven Rostedt (vice-chair)
>         Christian Brauner
>         Dan Williams
>         Greg Kroah-Hartman
>         Jonathan Corbet
>         Kees Cook
>         Laura Abbott
>         Sasha Levin
>         Ted Ts'o
>
>
> Introduction
>
> On April 20, 2021, in response to the perception that a group of
> University of Minnesota (UMN) researchers had resumed sending
> compromised code submissions to the Linux kernel, Greg Kroah-Hartman
> asked the community to stop accepting patches from UMN and began a
> re-review of all submissions previously accepted from the University.
> This report summarizes the events that led to this point, reviews the
> "Hypocrite Commits" paper that had been submitted for publication, and
> reviews all known prior kernel commits from UMN paper authors that had
> been accepted into our source repository.  It concludes with a few
> suggestions about how the community, with UMN included, can move
> forward.  Contributors to this paper include members of the Linux
> Foundation's Technical Advisory Board (TAB), with patch review help from
> many other members of the Linux kernel developer community.
>
> UMN worked well within the kernel community for many years, submitting
> numerous bug-fixes that were merged into past kernel releases.  Last
> year (2020), one member of the UMN community chose to do a research
> project that involved submitting patches that attempted to intentionally
> introduce flaws in the kernel.  The trust between the kernel community
> and UMN was broken when this project was made public.  The UMN
> developers went quiet for seven months and then started submitting a new
> handful of poor quality patches to the community.  Many assumed that
> trickery was afoot, engendering a reaction that caused a halt to
> acceptance of UMN kernel contributions and forced us to re-review all
> prior submissions.
>
> Due diligence required an audit to identify which authors were involved
> in different UMN research projects, identify the intent of any flawed
> patches, and remove flawed patches regardless of intent.  Reestablishing
> the community's trust in researcher groups is important as well, since
> this incident could have a wide-reaching impact on trust in both
> directions that might chill participation by any researchers in kernel
> development.  The developer community should be able to trust that
> researchers are sending quality patches meant to improve the kernel, and
> researchers should trust the developer community will not undermine the
> researchers' reputations when mistakes are made.  The recommendations in
> this report aim to move beyond this conflict, providing a way to help
> both communities to work together better.
>
>
> Timeline of events
>
> 2018:
>   - UMN bug-fix research on Linux kernel starts, and roughly 400 bug-fix
>     patches are contributed over the next two years, mainly centered
>     around specific research papers:
>         https://www-users.cs.umn.edu/~kjlu/papers/lrsan.pdf
>           ~21 commits, mostly 2018-04 through 2018-10
>         https://www-users.cs.umn.edu/~kjlu/papers/cheq.pdf
>           ~52 commits, mostly 2018-12 through 2019-01
>         https://www-users.cs.umn.edu/~kjlu/papers/crix.pdf
>           ~112 commits, mostly 2018-12 through 2019-09
>         https://www-users.cs.umn.edu/~kjlu/papers/k-meld.pdf
>           ~74 commits, mostly 2019-09 through 2020-01
>         https://www-users.cs.umn.edu/~kjlu/papers/eecatch.pdf
>           ~23 commits, mostly 2020-11 through 2020-02
>         https://www-users.cs.umn.edu/~kjlu/papers/hero.pdf
>           ~67 commits, mostly 2020-05 through 2020-06
>
> 2020 August:
>   - "Hypocrite Commits" patches from UMN researchers sent to kernel devel=
opers
>     under false identities:
>     - Aug 4 13:36-0500
>         https://lore.kernel.org/lkml/20200804183650.4024-1-jameslouisebon=
d@gmail.com
>     - Aug 9 17:14-0500
>         https://lore.kernel.org/lkml/20200809221453.10235-1-jameslouisebo=
nd@gmail.com
>     - Aug 20 22:12-0500
>         https://lore.kernel.org/lkml/20200821031209.21279-1-acostag.ubunt=
u@gmail.com
>     - Aug 20 22:44-0500
>         https://lore.kernel.org/lkml/20200821034458.22472-1-acostag.ubunt=
u@gmail.com
>     - Aug 21 02:05-0500
>         https://lore.kernel.org/lkml/20200821070537.30317-1-jameslouisebo=
nd@gmail.com
>
> 2020 November:
>   - "Hypocrite Commits" paper is published.
>         https://linuxreviews.org/images/d/d9/OpenSourceInsecurity.pdf
>
> 2020 November 21:
>   - "Hypocrite Commits" paper accepted by IEEESSP.
>         https://www.ieee-security.org/TC/SP2021/program-papers.html
>
> 2020 November 22:
>   - Sarah Jamie Lewis calls attention to paper's ethics.
>         https://twitter.com/SarahJamieLewis/status/1330618919376228352
>
> 2020 Dec 1:
>   - Sarah Jamie Lewis & others send a letter to IEEESSP.
>         https://hackmd.io/s/BJGs6Tfiw
>         https://twitter.com/SarahJamieLewis/status/1341542481280700418
>
> 2020 December ?:
>   - UMN IRB appears to give an exemption to the research.
>
> 2020 December 15:
>   - UMN issues clarification.
>         https://www-users.cs.umn.edu/~kjlu/papers/clarifications-hc.pdf
>
> 2021 April 6:
>   - Poor quality patches sent by UMN after 7 months of silence.
>         https://lore.kernel.org/lkml/20210407001658.2208535-1-pakki001@um=
n.edu
>
> 2021 April 20:
>   - Greg Kroah-Hartman asks submitters to stop sending poor quality
>     patches under the guise of "research on maintainers".
>         https://lore.kernel.org/r/YH6AOlbWdyCdVKvq@kroah.com
>         https://lore.kernel.org/r/YH5/i7OvsjSmqADv@kroah.com
>   - Researcher responds claiming that this new set of patches was not
>     part of previous research. (The mailing list dropped this email
>     because it was sent in HTML format, so there is no direct link to
>     it, but it is visible in Greg's reply below.)
>   - Greg replies and says that all umn.edu submissions should be
>     rejected until this is all figured out.
>         https://lore.kernel.org/lkml/YH%2FfM%2FTsbmcZzwnX@kroah.com
>
> 2021 April 21:
>   - Greg sends the initial @umn.edu revert series, requesting review by
>     any willing Linux maintainers.
>         https://lore.kernel.org/lkml/20210421130105.1226686-1-gregkh@linu=
xfoundation.org
>   - TAB starts investigation.
>   - UMN authors not using @umn.edu addresses are identified.
>   - "Hypocrite Commits" email threads are identified by community.
>         https://news.ycombinator.com/item?id=3D26895209
>   - Sarah Jamie Lewis follows up.
>         https://twitter.com/SarahJamieLewis/status/1384871385537908736
>
> 2021 April 22:
>   - TAB issues statement on review.
>         https://lore.kernel.org/lkml/202104221451.292A6ED4@keescook
>
> 2021 April 23:
>   - Linux Foundation sends letter to UMN.
>         https://drive.google.com/file/d/1bUsiJQesI4pCioE6h4ZUOghg0qHpemcb
>
> 2021 April 24:
>   - UMN publishes "An open letter to the Linux community"
>         https://lore.kernel.org/r/CAK8KejpUVLxmqp026JY7x5GzHU2YJLPU8SzTZU=
NXU2OXC70ZQQ@mail.gmail.com
>
> 2021 April 25:
>   - UMN starts collecting consent from "Hypocrite Commits" email thread
>     participants to allow their public emails to be called out directly
>     as part of the research.
>
> 2021 April 26:
>   - UMN retracts "Hypocrite Commits" paper.
>         https://www-users.cs.umn.edu/~kjlu/papers/withdrawal-letter.pdf
>
> 2021 April 27:
>   - UMN publishes details on "Hypocrite Commits" email threads.
>         https://www-users.cs.umn.edu/~kjlu/papers/full-disclosure.pdf
>   - UMN replies to LF
>         https://drive.google.com/file/d/1z3Nm2bfR4tH1nOGBpuOmLyoJVEiO9cUq=
/view
>
> 2021 April 28:
>   - Greg requests a revert of the attempted "Hypocrite" commit.
>         https://lore.kernel.org/linux-crypto/YIkTi9a3nnL50wMq@kroah.com
>
> 2021 April 29:
>   - Greg posts an update on the re-review along with some more reverts.
>         https://lore.kernel.org/lkml/20210429130811.3353369-1-gregkh@linu=
xfoundation.org
>
> 2021 May 3:
>   - Greg posts a final set of reverts, along with correct fixes for the
>     reverted changes.
>         https://lore.kernel.org/r/20210503115736.2104747-1-gregkh@linuxfo=
undation.org
>
> 2021 May 5:
>   - TAB publishes this report
>
>
> Patches submitted as part of the "Hypocrite Commits" research paper
>
> After getting consent from all participants in the public "Hypocrite
> Commits" patch discussion threads, UMN published a full disclosure on
> the details of their actions surrounding the paper.
>         https://www-users.cs.umn.edu/~kjlu/papers/full-disclosure.pdf
>
> The authors of the paper identify five changes that were submitted to
> the public Linux kernel mailing list, which matched the threads publicly
> identified earlier.  These changes were submitted using two fake
> identities, which is against the documented requirements for how to
> contribute code to the Linux kernel.  The University appears to have
> allowed researchers to use fake identities when agreeing to the
> "Developers Certificate of Origin", a legal statement about the work
> being submitted.
>         https://www.kernel.org/doc/html/latest/process/submitting-patches=
.html#sign-your-work-the-developer-s-certificate-of-origin
>
> The patches listed below map to the patch numbers that the researchers
> use in their disclosure statement.  We do note that the ordering is not
> chronological; the patches were sent to the community in the order of 5,
> 2, 1, 3, 4 with the specific times noted below (and above in the
> timeline of events).
>
> Patch 1
>
> First email: Thu, 20 Aug 2020 22:12:08 -0500 (Fri, 21 Aug 2020 03:12:08 U=
TC)
> First reply: Fri, 28 Aug 2020 17:19:31 +1000 (Fri, 28 Aug 2020 07:19:31 U=
TC)
>         https://lore.kernel.org/lkml/20200821031209.21279-1-acostag.ubunt=
u@gmail.com
>
> This change was accepted into the kernel repository, after a review by
> the subsystem maintainer, and showed up in the kernel repository as:
>         9fcddaf2e28d crypto: cavium/nitrox - add an error message to expl=
ain the failure of pci_request_mem_regions
>
> This change was valid.  The author's attempt to create an invalid change
> failed as they did not understand how the PCI driver model worked within
> the kernel.  They asked for clarification about this change after the
> maintainer accepted the change, and were told that it was acceptable.
> Why the authors claimed in the submitted paper that this was an
> incorrect change is not clear.
>
> Because this submission was made under a false name, it was asked to be
> removed from the kernel repository as the kernel community does not
> accept known-anonymous contributions as documented above in the link to
> the "Submitting Patches" kernel documentation.  There have been
> exceptions made to this rule before, but those have been done for very
> specific reasons unique to the individual contributors; their true
> identities are known to a subset of existing kernel maintainers.
>         https://lore.kernel.org/r/YIkTi9a3nnL50wMq@kroah.com
>
> Patch 2
>
> First email: Sun,  9 Aug 2020 17:14:52 -0500 (Sun, 09 Aug 2020 22:14:52 U=
TC)
> First reply: Mon, 10 Aug 2020 07:16:48 +0200 (Mon, 10 Aug 2020 05:16:48 U=
TC)
>         https://lore.kernel.org/lkml/20200809221453.10235-1-jameslouisebo=
nd@gmail.com
>
> This patch was a copy of a previously submitted change in this very
> area, trying to get acceptance of the patch by quoting the syzbot tool.
> The maintainers quickly recognized that this change was invalid, and
> rejected it.  Ironically, the earlier bad patch had actually inspired an
> entire presentation calling attention to how CVEs do not work well for
> tracking kernel bugs:
>         https://kernel-recipes.org/en/2019/talks/cves-are-dead-long-live-=
the-cve/
>
> Patch 3
>
> First email: Thu, 20 Aug 2020 22:44:57 -0500 (Fri, 21 Aug 2020 03:44:57 U=
TC)
> First reply: Fri, 21 Aug 2020 11:14:49 +0300 (Fri, 21 Aug 2020 08:14:49 U=
TC)
>         https://lore.kernel.org/lkml/20200821034458.22472-1-acostag.ubunt=
u@gmail.com
>
> This patch was quickly recognized by a reviewer to be incorrect, and the
> reviewer offered up possible changes that the submitter could make in
> order to turn it into a correct change.  These suggestions were ignored
> by the submitter and no further changes were submitted in this area.
>
> The maintainer was attempting to mentor an obviously junior contributor,
> taking time to teach the developer what the proper thing to do here
> would be, and what is needed in order to have them create a
> contribution that would be acceptable.  The contributor knew that the
> patch was bad, showing that the researchers were willing to waste the
> resource that is in shortest supply in our community: the time of
> reviewers and maintainers.  Having this waste of an "effort of someone
> trying to teach another" be created by an educational institution was
> especially hurtful to the community and caused many of the bad feelings
> on the community's side, further amplified by not having any idea which
> patches out of the hundreds sent by UMN or from new contributors using
> gmail accounts might be intentionally bad.
>
> Patch 4
>
> First email: Fri, 21 Aug 2020 02:05:36 -0500 (Fri, 21 Aug 2020 07:05:36 U=
TC)
> First reply: Thu, 27 Aug 2020 14:46:00 +0200 (Thu, 27 Aug 2020 12:46:00 U=
TC)
>         https://lore.kernel.org/lkml/20200821070537.30317-1-jameslouisebo=
nd@gmail.com
>
> This patch was reviewed by the maintainer of the driver, found to be
> incorrect, and suggestions were made as to what could be done instead to
> make the change in a correct manner. The submitter did respond, saying
> that their original attempt was incorrect, and apologized for bothering
> the developers.
>
> Patch 5
>
> First email: Tue,  4 Aug 2020 13:36:49 -0500 (Tue, 04 Aug 2020 18:36:49 U=
TC)
>         https://lore.kernel.org/lkml/20200804183650.4024-1-jameslouisebon=
d@gmail.com
>
> According to the researchers, this patch was submitted as an independent
> patch and not part of the "Hypocrite" research, attempting a legitimate
> fix. The developer had configured their system to use the fake name in
> preparation for the "Hypocrite" submissions so it showed up to the world
> as coming from "James Bond." This claim is supported by the fact that
> the function being patched, dmi_system_event_log(), shows up in the
> named bug list for the "Disordered Error Handling" research paper, and
> an earlier attempt was made to make this change (with a real name).
> However, the latter attempt from "James Bond" is incomplete compared to
> the earlier fix attempt.
>         https://lore.kernel.org/lkml/20200613192424.19884-1-wu000273@umn.=
edu
>
> When the "James Bond" submission was eventually reviewed by the
> maintainer of this subsystem a few weeks later, this name was known by
> the kernel developer community to be false (during the earlier review of
> Patch 2), so the submission was just ignored.
>         https://lore.kernel.org/lkml/20200810075122.GA1531406@kroah.com
>
> Summary of "Hypocrite Commits" patch attempts
>
> All patch submissions that were invalid were caught, or ignored, by the
> Linux kernel developers and maintainers.  Our patch-review processes
> worked as intended when confronted with these malicious patches.
>
>
> Summary of review
>
> 435 commits were re-reviewed.  Two sets of commit reviews were done in
> public and can be seen in these email threads:
>         https://lore.kernel.org/r/20210421130105.1226686-1-gregkh@linuxfo=
undation.org
>         https://lore.kernel.org/r/20210429130811.3353369-1-gregkh@linuxfo=
undation.org
>
> A third set of reviews were done by TAB members covering the commits
> made by UMN authors that were using other email accounts (i.e. not
> @umn.edu).
>
> Full details of each of the changes that were reviewed can be found
> below in the section "Details of Review".  We can summarize the review
> of these commits into the following categories with the number in each
> category:
>         - commits found to be correct (349)
>         - commits found to be incorrect and in need of fixing (39)
>         - commits already fixed by later commits (25)
>         - commits that no longer matter (12)
>         - commits made before the research group existed (9)
>         - commits the author asked to have removed (1)
>
> Commits found to be correct
>
> The huge majority of the reviewed commits were found to be correct.
> These 349 commits are marked with "c" in the "Commit Determination"
> field below, with any public review URLs noted in the indented lines
> following the commit reference.
>
> Commits found to be incorrect and in need of fixing
>
> During the re-review, a number of commits were found to have some problem
> with them.  These 39 commits are going to be reverted, and a replacement
> commit will be submitted to resolve any remaining problems in a correct
> manner before the 5.13 kernel release.  They are marked with "I" or "H" i=
n
> the "Commit Determination" field below, with any public review URLs noted
> in the indented lines following the commit reference.
>
> Commits already fixed by later commits
>
> 25 commits were independently found to be incorrect after acceptance
> into the kernel and were subsequently reverted or fixed by other
> developers.  As the end-result of these changes is now correct, the
> original incorrect commits do not need to be removed.  These commits are
> marked with "r" or "f" in the "Commit Disposition" field below, with any
> existing fixes, reverts, or public review URLs noted in the indented
> lines following the commit reference.
>
> Commits that no longer matter
>
> Several commits no longer matter as the code they touched had been
> removed from the kernel before the incident due to drivers and
> subsystems having become obsolete.  These 12 commits are marked with "n"
> in the "Commit Determination" field below, with any public review URLs
> noted in the indented lines following the commit reference.
>
> Commits made before the research group existed
>
> A handful of very old commits made by developers using an @umn.edu email
> address were also reviewed again and were found not to be causing any
> obvious problems.  These 9 commits are marked with "o" in the "Commit
> Determination" field below.
>
> Commits the author asked to have removed
>
> One incorrect commit was reverted from the source tree at the request of
> the author.  It is marked with "a" in the "Commit Disposition" field
> below, with the thread URL noted in the indented line following the
> commit reference.
>
>
> Details of review
>
> Authors of UMN papers researching the Linux kernel:
>         Aditya Pakki <pakki001@umn.edu>
>         Qiushi Wu <wu000273@umn.edu>
>         Kangjie Lu <kjlu@umn.edu>
>         Wenwen Wang <wang6495@umn.edu>
>         Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Earliest commit date from any of above:
>         Tue May 3 16:32:16 2016 -0400
>
> Hypocrite patch attempts:
>         George Acosta <acostag.ubuntu@gmail.com>
>         James Bond <jameslouisebond@gmail.com>
>
> Later addresses:
>         Wenwen Wang <wenwen@cs.uga.edu>
>
> Earlier addresses:
>         Kangjie Lu <kjlu@gatech.edu>
>         Kangjie Lu <kangjielu@gmail.com>
>
> Before current incident:
>         Alireza Haghdoost <alireza@cs.umn.edu>
>         Dave C Boutcher <boutcher@cs.umn.edu>
>
> Commit log regular expression:
>         ((pakki001|kjlu|wu000273|wang6495)@umn\.edu|navid\.emamdoost@gmai=
l\.com|wenwen@cs\.uga\.edu|kjlu@gatech\.edu|(acostag\.ubuntu|jameslouisebon=
d|kangjielu)@gmail\.com)
>
> First column key ("Review origin"):
> 1 =3D in original re-review series
>     https://lore.kernel.org/lkml/20210421130105.1226686-1-gregkh@linuxfou=
ndation.org
> 2 =3D in original "needs special attention" review series
>     https://lore.kernel.org/lkml/YIAtwtOpy%2FemQWr2@kroah.com
> 3 =3D involves a UMN author not covered by 1 and 2 above.
>     (e.g. Reported-by:, or Author: not @umn.edu)
>     git log --pretty=3Dformat:'%h %as %>(16)%aN  %s' --no-merges -E --gre=
p "$RE"
> n =3D commit by non-UMN author referencing an incident-related commit or =
author
>     git log --oneline --no-merges -E --grep "Fixes: (commit )?($SHA_RE)"
>
> Second column key ("Commit Determination"):
> c =3D apparently correct commit
> I =3D incorrect fix (e.g. in need of revert or fix)
> H =3D attempted hypocrite commit
> n =3D no longer relevant (e.g. entire driver removed)
> o =3D commit unrelated to incident
>
> Third column key ("Commit Disposition"):
> R =3D revert and fix after incident
> f =3D received fixes before the incident
> r =3D reverted before the incident
> a =3D reverted by author
> - =3D no further changes needed
>
> Commits sorted by apparent research origins:
>
> # On the Feasibility of Stealthily Introducing Vulnerabilities in Open-So=
urce Software via Hypocrite Commits
> # https://linuxreviews.org/images/d/d9/OpenSourceInsecurity.pdf
> # Qiushi Wu and Kangjie Lu
> 3HR 9fcddaf2e28d 2020-08-20    George Acosta  crypto: cavium/nitrox - add=
 an error message to explain the failure of pci_request_mem_regions
>
> # Understanding and Detecting Disordered Error Handling with Precise Func=
tion Pairing
> # https://www-users.cs.umn.edu/~kjlu/papers/hero.pdf
> # Qiushi Wu, Aditya Pakki, Navid Emamdoost, Stephen McCamant, Kangjie Lu
> nf- 4684709bf81a 2020-12-02      Jubin Zhong  PCI: Fix pci_slot_release()=
 NULL pointer dereference
> nf- b9ad3e9f5a7a 2020-11-20       Jamie Iles  bonding: wait for sysfs kob=
ject destruction before freeing struct slave
> nf- a39d0d7bdf8c 2020-09-28     Jean Delvare  drm/amdgpu: restore proper =
ref count in amdgpu_display_crtc_set_config
> 1c- 6f4432bae9f2 2020-06-14        Qiushi Wu  media: sti: Fix reference c=
ount leaks
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 7ef64ceea000 2020-06-14        Qiushi Wu  media: exynos4-is: Fix seve=
ral reference count leaks due to pm_runtime_get_sync
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- c47f7c779ef0 2020-06-14        Qiushi Wu  media: exynos4-is: Fix a re=
ference count leak due to pm_runtime_get_sync
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 64157b2cb194 2020-06-14        Qiushi Wu  media: exynos4-is: Fix a re=
ference count leak
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 88f50a05f907 2020-06-14        Qiushi Wu  media: stm32-dcmi: Fix a re=
ference count leak
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 78741ce98c2e 2020-06-14        Qiushi Wu  media: s5p-mfc: Fix a refer=
ence count leak
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- d0675b67b42e 2020-06-14        Qiushi Wu  media: camss: Fix a referen=
ce count leak.
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 63e36a381d92 2020-06-14        Qiushi Wu  media: platform: fcp: Fix a=
 reference count leak.
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 884d638e0853 2020-06-14        Qiushi Wu  media: rockchip/rga: Fix a =
reference count leak.
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 410822037cc9 2020-06-14        Qiushi Wu  media: rcar-vin: Fix a refe=
rence count leak.
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- aaffa0126a11 2020-06-14        Qiushi Wu  media: rcar-vin: Fix a refe=
rence count leak.
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- fe3c60684377 2020-06-13        Qiushi Wu  firmware: Fix a reference c=
ount leak.
>         https://lore.kernel.org/r/YIg7ZOZvS3a8LjSv@kroah.com
> 1c- 659fb5f154c3 2020-06-13     Aditya Pakki  drm/nouveau: fix multiple i=
nstances of reference count leaks
>         https://lore.kernel.org/r/YIg65CAxgmBIu4ty@kroah.com
> 1c- 78c2ce9bde70 2020-06-13     Aditya Pakki  omapfb: fix multiple refere=
nce count leaks due to pm_runtime_get_sync
>         https://lore.kernel.org/r/YIhLXCVUh+TsmlaT@kroah.com
> 3c- f79f94765f8c 2020-06-14  Navid Emamdoost  drm/amdgpu/display: fix ref=
 count leak when pm_runtime_get_sync fails
> 1c- 6f2e8acdb48e 2020-06-13     Aditya Pakki  drm/radeon: fix multiple re=
ference count leak
>         https://lore.kernel.org/r/MN2PR12MB44889F62CD7F3EAC7572AEA2F7479@=
MN2PR12MB4488.namprd12.prod.outlook.com
> 1c- 20eca0123a35 2020-06-13        Qiushi Wu  drm/amdkfd: Fix reference c=
ount leaks.
>         https://lore.kernel.org/r/5c09de50-d013-e5a3-d638-f1ca222a6431@am=
d.com
> 1c- f141a422159a 2020-06-13        Qiushi Wu  ASoC: rockchip: Fix a refer=
ence count leak.
>         https://lore.kernel.org/r/YIg7gWWkgqnj1S/K@kroah.com
> 1c- 90a239ee25fa 2020-06-13     Aditya Pakki  RDMA/rvt: Fix potential mem=
ory leak caused by rvt_alloc_rq
>         https://lore.kernel.org/r/20210421141105.GK1370958@nvidia.com
> 1c- 17ed808ad243 2020-05-28        Qiushi Wu  EDAC: Fix reference count l=
eaks
>         https://lore.kernel.org/r/20210421185555.GA24470@zn.tnic
> 1c- deca195383a6 2020-06-13        Qiushi Wu  ASoC: tegra: Fix reference =
count leaks.
>         https://lore.kernel.org/r/YIg7kH1X0qk8hidp@kroah.com
> 3c- 79c43333bdd5 2020-06-04  Navid Emamdoost  can: xilinx_can: handle fai=
lure cases of pm_runtime_get_sync
> 3c- 861254d82649 2020-06-04  Navid Emamdoost  gpio: arizona: put pm_runti=
me in case of failure
> 3c- e6f390a834b5 2020-06-04  Navid Emamdoost  gpio: arizona: handle pm_ru=
ntime_get_sync failure case
> 1c- a6379f0ad637 2020-06-12     Aditya Pakki  test_objagg: Fix potential =
memory leak in error handling
>         https://lore.kernel.org/r/YIkKkHJgiWCjZt2y@kroah.com
> 1c- 6b9fbb073636 2020-06-13        Qiushi Wu  ASoC: img-parallel-out: Fix=
 a reference count leak
>         https://lore.kernel.org/r/YIg7plCKyGRcx582@kroah.com
> 3c- d88de040e1df 2020-06-04  Navid Emamdoost  iio: pressure: zpa2326: han=
dle pm_runtime_get_sync failure
> 3c- eea123886720 2020-06-04  Navid Emamdoost  sata_rcar: handle pm_runtim=
e_get_sync failure cases
> 3c- ca162ce98110 2020-06-01  Navid Emamdoost  pwm: img: Call pm_runtime_p=
ut() in pm_runtime_get_sync() failed case
> 1c- aa8ba13cae31 2020-05-27        Qiushi Wu  vfio/mdev: Fix reference co=
unt leak in add_mdev_supported_type
>         https://lore.kernel.org/r/20210421183634.GA2290758@nvidia.com
> 1c- 0b8e125e2132 2020-05-27        Qiushi Wu  RDMA/core: Fix several refe=
rence count leaks.
>         https://lore.kernel.org/r/20210421141444.GL1370958@nvidia.com
> 1c- c343bf1ba5ef 2020-05-28        Qiushi Wu  cpuidle: Fix three referenc=
e count leaks
>         https://lore.kernel.org/r/YIg+B0sSR+7QMXZx@kroah.com
> 1c- 4d8be4bc94f7 2020-05-27        Qiushi Wu  ACPI: CPPC: Fix reference c=
ount leak in acpi_cppc_processor_probe()
>         https://lore.kernel.org/r/YIgkr/swUm/8sjPf@kroah.com
> 1c- b975abbd382f 2020-05-22        Qiushi Wu  agp/intel: Fix a memory lea=
k on module initialisation failure
>         https://lore.kernel.org/r/YIhI1j7TOdBA+FcN@kroah.com
> 1c- 1d7a7128a2e9 2020-05-02        Qiushi Wu  power: supply: core: fix me=
mory leak in HWMON error path
>         https://lore.kernel.org/r/20210421155101.n2mbmhj6x42i3a4l@earth.u=
niverse
> 1c- 57cc666d36ad 2020-06-14     Aditya Pakki  media: st-delta: Fix refere=
nce count leak in delta_run_work
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 7dae2aaaf432 2020-06-14        Qiushi Wu  media: ti-vpe: Fix a missin=
g check and reference count leak
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 3c- 9df0e0c18896 2020-06-14  Navid Emamdoost  drm/panfrost: perfcnt: fix =
ref count leak in panfrost_perfcnt_enable_locked
> 1c- 9fb106710111 2020-06-13     Aditya Pakki  drm/radeon: Fix reference c=
ount leaks caused by pm_runtime_get_sync
>         https://lore.kernel.org/r/MN2PR12MB4488CE1D9E2133F4110D131EF7479@=
MN2PR12MB4488.namprd12.prod.outlook.com
> 1c- 8f29432417b1 2020-06-13     Aditya Pakki  drm/nouveau: fix reference =
count leak in nouveau_debugfs_strap_peek
>         https://lore.kernel.org/r/YIg6zHrrywU+6K7q@kroah.com
> 2c- 990a1162986e 2020-06-13     Aditya Pakki  drm/nouveau: Fix reference =
count leak in nouveau_connector_detect
> 1c- a2cdf39536b0 2020-06-13     Aditya Pakki  drm/nouveau: fix reference =
count leak in nv50_disp_atomic_commit
>         https://lore.kernel.org/r/YIg6tVGPKdhv49ll@kroah.com
> 1c- bfad51c76333 2020-06-13     Aditya Pakki  drm/nouveau/drm/noveau: fix=
 reference count leak in nouveau_fbcon_open
>         https://lore.kernel.org/r/YIg67pFY6socFDCY@kroah.com
> 3c- c5d5a32ead1e 2020-06-15  Navid Emamdoost  drm/etnaviv: fix ref count =
leak via pm_runtime_get_sync
> 1c- 8a94644b440e 2020-05-27        Qiushi Wu  PCI: Fix pci_create_slot() =
reference count leak
>         fixed by: 4684709bf81a PCI: Fix pci_slot_release() NULL pointer d=
ereference
>         https://lore.kernel.org/r/20210422044331.GA2907704@bjorn-Precisio=
n-5520
> 3If e008fa6fb415 2020-06-14  Navid Emamdoost  drm/amdgpu: fix ref count l=
eak in amdgpu_display_crtc_set_config
>         fixed by: a39d0d7bdf8c drm/amdgpu: restore proper ref count in am=
dgpu_display_crtc_set_config
> 3c- 5509ac65f2fe 2020-06-14  Navid Emamdoost  drm/amd/display: fix ref co=
unt leak in amdgpu_drm_ioctl
> 3c- 9ba8923cbbe1 2020-06-14  Navid Emamdoost  drm/amdgpu: fix ref count l=
eak in amdgpu_driver_open_kms
> 1c- aaa3cbbac326 2020-05-22        Qiushi Wu  platform/chrome: cros_ec_is=
htp: Fix a double-unlock issue
>         https://lore.kernel.org/r/8825f20c-7e58-c44e-fa7a-bca811add5a1@co=
llabora.com
> 3c- d4f5a095daf0 2020-06-15  Navid Emamdoost  drm/exynos: fix ref count l=
eak in mic_pre_enable
> 1c- 2655971ad4b3 2020-06-13     Aditya Pakki  usb: dwc3: pci: Fix referen=
ce count leak in dwc3_pci_resume_work
>         https://lore.kernel.org/r/87fszimtpy.fsf@kernel.org
> 2c- 58d0c864e1a7 2020-06-12     Aditya Pakki  rocker: fix incorrect error=
 handling in dma_rings_init
>         https://lore.kernel.org/r/YIq6iA+C1gdfopYj@kroah.com
> 1c- c4c59b95b7f7 2020-06-13        Qiushi Wu  ASoC: img: Fix a reference =
count leak in img_i2s_in_set_fmt
>         https://lore.kernel.org/r/YIg7sSTw8BTtCzqf@kroah.com
> 1c- 4ddf4739be6e 2020-05-28        Qiushi Wu  efi/esrt: Fix reference cou=
nt leak in esre_create_sysfs_entry.
>         https://lore.kernel.org/r/CAMj1kXEYLKJX3DfzPAT78iQMMpXWmEGtBbjQDy=
fZzTR3pYBxMw@mail.gmail.com
> 1c- 0267ffce562c 2020-05-28        Qiushi Wu  scsi: iscsi: Fix reference =
count leak in iscsi_boot_create_kobj
>         https://lore.kernel.org/r/YIg+LkC9In2J6aYv@kroah.com
> 1c- 7cc31613734c 2020-05-27        Qiushi Wu  iommu: Fix reference count =
leak in iommu_group_alloc.
>         https://lore.kernel.org/r/YIErPGXVW1masuNW@suse.de
> 2If a068aab42258 2020-05-27        Qiushi Wu  bonding: Fix reference coun=
t leak in bond_sysfs_slave_add.
>         fixed by: b9ad3e9f5a7a bonding: wait for sysfs kobject destructio=
n before freeing struct slave
> 1c- 6e6c25283dff 2020-05-27        Qiushi Wu  ACPI: sysfs: Fix reference =
count leak in acpi_sysfs_add_hotplug_profile()
>         https://lore.kernel.org/r/YIgk0Dydbn42D7zI@kroah.com
> 1c- 25bf943e4e7b 2020-05-25        Qiushi Wu  ASoC: fix incomplete error-=
handling in img_i2s_in_probe.
>         https://lore.kernel.org/r/YIg7/fzC6a1YdLmm@kroah.com
> 1c- 15c973858903 2020-05-25        Qiushi Wu  qlcnic: fix missing release=
 in qlcnic_83xx_interrupt_test.
>         https://lore.kernel.org/r/YIkLLvS7mLLCsTCL@kroah.com
> 1c- db857e6ae548 2020-05-22        Qiushi Wu  RDMA/pvrdma: Fix missing pc=
i disable in pvrdma_pci_probe()
>         https://lore.kernel.org/r/20210421141031.GJ1370958@nvidia.com
> 1c- 44734a594196 2020-05-22        Qiushi Wu  usb: gadget: fix potential =
double-free in m66592_probe.
>         https://lore.kernel.org/r/87czummtnw.fsf@kernel.org
> 1c- febfd9d3c7f7 2020-05-22        Qiushi Wu  net/mlx4_core: fix a memory=
 leak bug.
>         https://lore.kernel.org/r/YIrp5CMmMugYg4Zk@kroah.com
> 1c- f45d01f4f30b 2020-05-22        Qiushi Wu  rxrpc: Fix a memory leak in=
 rxkad_verify_response()
>         https://lore.kernel.org/r/2189111.1619022623@warthog.procyon.org.=
uk
> 1c- 5a730153984d 2020-05-22        Qiushi Wu  net: sun: fix missing relea=
se regions in cas_init_one().
>         https://lore.kernel.org/r/YIkK5kBlqHD7nud9@kroah.com
> 2c- 8816cd726a4f 2020-05-03        Qiushi Wu  rtc: mc13xxx: fix a double-=
unlock issue
>         https://lore.kernel.org/r/YIq6DAb3drmrseJD@kroah.com
> 1c- bd4af432cc71 2020-05-02        Qiushi Wu  nfp: abm: fix a memory leak=
 bug
>         https://lore.kernel.org/r/20210421090315.11cc4eaf@kicinski-fedora=
-pc1c0hjn.dhcp.thefacebook.com
>
> # Exaggerated Error Handling Hurts! An In-Depth Study and Context-Aware D=
etection
> # https://www-users.cs.umn.edu/~kjlu/papers/eecatch.pdf
> # Aditya Pakki, and Kangjie Lu
> 1c- 639c0a5b0503 2019-12-19     Aditya Pakki  media: media/saa7146: fix i=
ncorrect assertion in saa7146_buffer_finish
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1IR 2c2a7552dd64 2020-02-14     Aditya Pakki  ecryptfs: replace BUG_ON wi=
th error handling code
>         https://lore.kernel.org/r/YIBM8hiBLFO+JJr/@zeniv-ca.linux.org.uk
> 1c- 8d7a577d04e8 2020-01-21     Aditya Pakki  clk: samsung: Remove redund=
ant check in samsung_cmu_register_one
>         https://lore.kernel.org/r/05bd90cf-e761-9ade-388c-7b78a0ed716a@ca=
nonical.com
> 1c- 67e2d2eb5423 2020-01-30     Aditya Pakki  fs: ocfs: remove unnecessar=
y assertion in dlm_migrate_lockres
>         https://lore.kernel.org/r/20210422084208.GB5316@amd
> 1c- b0e4cfae483f 2020-01-06     Aditya Pakki  media: davinci/vpfe_capture=
.c: Avoid BUG_ON for register failure
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 1ec4c6efe231 2019-12-15     Aditya Pakki  media: saa7146: Avoid using=
 BUG_ON as an assertion
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 93a24578de72 2019-12-15     Aditya Pakki  media: cx231xx: replace BUG=
_ON with recovery code
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- 9f48db0d4a08 2019-12-17     Aditya Pakki  RDMA/srpt: Remove unnecessa=
ry assertion in srpt_queue_response
>         https://lore.kernel.org/r/20210421140247.GG1370958@nvidia.com
> 1c- d7a336d67ab5 2019-12-19     Aditya Pakki  staging: kpc2000: remove un=
necessary assertions in kpc_dma_transfer
>         https://lore.kernel.org/r/YIf7h/G8VOz02VgZ@kroah.com
> 1c- d6bd6cf9feb8 2019-12-17     Aditya Pakki  xen/grant-table: remove mul=
tiple BUG_ON on gnttab_interface
>         https://lore.kernel.org/r/9c52814a-7db1-1989-6fd2-e6d80f9a92ad@su=
se.com
> 1c- 52b894393cec 2019-12-17     Aditya Pakki  scsi: libfc: remove unneces=
sary assertion on ep variable
>         https://lore.kernel.org/r/YIhH9xo5cpv5ha0y@kroah.com
> 1c- a886ca6fcfff 2019-12-17     Aditya Pakki  hdlcdrv: replace unnecessar=
y assertion in hdlcdrv_register
>         https://lore.kernel.org/r/YIhaf3GrmPGwrUWq@kroah.com
> 1c- 615f22f58029 2019-12-17     Aditya Pakki  nfc: s3fwrn5: replace the a=
ssertion with a WARN_ON
>         https://lore.kernel.org/r/9c2877c3-8077-c2e2-ed0d-80b2a0c87634@ca=
nonical.com
> 1c- fc1b20659597 2019-12-17     Aditya Pakki  nfsd: remove unnecessary as=
sertion in nfsd4_encode_replay
>         https://lore.kernel.org/r/YIA3lhTMV2Ib1KLx@pick.fieldses.org
> 1c- 5bf2fc1f9c88 2019-12-19     Aditya Pakki  bpf: Remove unnecessary ass=
ertion on fp_old
>         https://lore.kernel.org/r/CAADnVQKrsue+0tCCjU9wzGALPqWZXF2vxUH1hJ=
uF7uJkf5x+oQ@mail.gmail.com
> 2c- c705f9fc6a17 2019-12-15     Aditya Pakki  orinoco: avoid assertion in=
 case of NULL pointer
>         https://lore.kernel.org/r/YIq5uQoBLuYvoFTk@kroah.com
> 2c- 8b6fc114beeb 2019-12-15     Aditya Pakki  drm: remove duplicate check=
 on parent and avoid BUG_ON
> 1IR c5dea815834c 2019-12-15     Aditya Pakki  net: caif: replace BUG_ON w=
ith recovery code
>         https://lore.kernel.org/r/YIj0b9AFaDY8prNO@kroah.com
> 1c- bbd20c939c8a 2019-12-15     Aditya Pakki  fore200e: Fix incorrect che=
cks of NULL pointer dereference
>         https://lore.kernel.org/r/YIhQYJancyH7NhBt@kroah.com
> 1c- 1ee7826ab68f 2019-12-15     Aditya Pakki  mac80211: Remove redundant =
assertion
>         https://lore.kernel.org/r/685d055406cb9fd28fec3ac0b9ba3fc3fe039f0=
8.camel@sipsolutions.net
> 2c- 169f9acae086 2019-12-05     Aditya Pakki  spi: dw: Avoid BUG_ON() in =
case of host failure
> 1c- 02a896ca8487 2019-12-05     Aditya Pakki  pppoe: remove redundant BUG=
_ON() check in pppoe_pernet
>         https://lore.kernel.org/r/YIhLMcU71EKGi+qE@kroah.com
> 1c- 60f5c4aaae45 2019-11-17     Aditya Pakki  net: atm: Reduce the severi=
ty of logging in unlink_clip_vcc
>         https://lore.kernel.org/r/YIjyzCHeBEwQjPYj@kroah.com
>
> # Detecting Kernel Memory Leaks in Specialized Modules with Ownership Rea=
soning
> # https://www-users.cs.umn.edu/~kjlu/papers/k-meld.pdf
> # Navid Emamdoost, Qiushi Wu, Kangjie Lu, Stephen McCamant
> nf- 579dd91ab3a5 2020-06-29        Zheng Bin  nbd: Fix memory leak in nbd=
_add_socket
> nf- 7174dc655ef0 2020-12-07     Lukas Wunner  spi: gpio: Don't leak SPI m=
aster in probe error path
> nf- e163fdb3f7f8 2020-01-08        Kees Cook  pstore/ram: Regularize prz =
label allocation lifetime
> nf- cad46039e4c9 2019-12-17    Ben Hutchings  net: qlogic: Fix error path=
s in ql_alloc_large_buffers()
> 3c- f6c992ca7dd4 2020-08-09  Navid Emamdoost  clk: bcm2835: add missing r=
elease if devm_clk_hw_register fails
> 3c- e6827d1abdc9 2020-07-22  Navid Emamdoost  cxgb4: add missing release =
on skb in uld_send()
> 3c- 880e21490be6 2020-07-18  Navid Emamdoost  mt7601u: add missing releas=
e on skb in mt7601u_mcu_msg_send
> 3c- 5648d1c9cadb 2020-07-18  Navid Emamdoost  mt76: mt76u: add missing re=
lease on skb in __mt76x02u_mcu_send_msg
> 3c- 1e8fd3a97f2d 2020-07-18  Navid Emamdoost  nfc: s3fwrn5: add missing r=
elease on skb in s3fwrn5_recv_frame
> 3c- c3df30a01da4 2019-11-10  Navid Emamdoost  media: aspeed-video: Fix me=
mory leaks in aspeed_video_probe
> 3c- 40efb09a7f53 2019-09-24  Navid Emamdoost  drm/vmwgfx: prevent memory =
leak in vmw_cmdbuf_res_add
> 3c- a7c46c0c0e3d 2020-01-04  Navid Emamdoost  mm/gup: fix memory leak in =
__gup_benchmark_ioctl
> nIf 8df955a32a73 2019-12-30        Kees Cook  pstore/ram: Fix error-path =
memory leak in persistent_ram_new() callers
>         fixed by: e163fdb3f7f8 pstore/ram: Regularize prz label allocatio=
n lifetime
> 3c- 4282dc057d75 2019-12-14  Navid Emamdoost  brcmfmac: Fix memory leak i=
n brcmf_usbdev_qinit
> 3c- 5cc509aa83c6 2019-11-22  Navid Emamdoost  brcmfmac: Fix memory leak i=
n brcmf_p2p_create_p2pdev()
> 3c- f37f71035367 2019-12-14  Navid Emamdoost  net: gemini: Fix memory lea=
k in gmac_setup_txqs
> 3c- 8c386cc81787 2019-11-25  Navid Emamdoost  PCI/IOV: Fix memory leak in=
 pci_iov_add_virtfn()
> 3c- 6645d42d79d3 2019-11-22  Navid Emamdoost  dma-buf: Fix memory leak in=
 sync_file_merge()
> 3c- b6631c6031c7 2019-11-22  Navid Emamdoost  sctp: Fix memory leak in sc=
tp_sf_do_5_2_4_dupcook
> 3c- d088337c38a5 2019-11-21  Navid Emamdoost  Bluetooth: Fix memory leak =
in hci_connect_le_scan
> 3c- 450c3d416683 2019-10-02  Navid Emamdoost  affs: fix a memory leak in =
affs_remount
> 3c- e13de8fe0d6a 2019-10-04  Navid Emamdoost  of: unittest: fix memory le=
ak in unittest_data_add
> 3c- 4aa7afb0ee20 2019-10-21  Navid Emamdoost  ipmi: Fix memory leak in __=
ipmi_bmc_register
> 3c- 1399c59fa929 2019-10-04  Navid Emamdoost  nl80211: fix memory leak in=
 nl80211_get_ftm_responder_stats
> 3c- 80b15db5e1e9 2019-10-04  Navid Emamdoost  staging: vt6655: Fix memory=
 leak in vt6655_probe
> 3c- 5bdea6060618 2019-09-29  Navid Emamdoost  Staging: fbtft: fix memory =
leak in fbtft_framebuffer_alloc
> 3c- 1104057562ec 2019-10-01  Navid Emamdoost  drm/amdgpu: fix multiple me=
mory leaks in acp_hw_init
> 3c- 57be09c6e874 2019-10-01  Navid Emamdoost  drm/amdgpu: fix multiple me=
mory leaks in acp_hw_init
> 3c- 057b8945f78f 2019-09-29  Navid Emamdoost  spi: lpspi: fix memory leak=
 in fsl_lpspi_probe
> 3If d3b0ffa1d75d 2019-09-30  Navid Emamdoost  spi: gpio: prevent memory l=
eak in spi_gpio_probe
>         fixed by: 7174dc655ef0 spi: gpio: Don't leak SPI master in probe =
error path
> 3c- ca312438cf17 2019-09-19  Navid Emamdoost  staging: rtl8192u: fix mult=
iple memory leaks on error path
> 3c- 0911224b6bf4 2019-09-19  Navid Emamdoost  staging: rtl8192u: release =
memory on error path
> 3Ir 78beef629fd9 2019-09-26  Navid Emamdoost  nfp: abm: fix memory leak i=
n nfp_abm_u32_knode_replace
>         reverted by: 1d1997db870f Revert "nfp: abm: fix memory leak in nf=
p_abm_u32_knode_replace"
> 3If 03bf73c315ed 2019-09-23  Navid Emamdoost  nbd: prevent memory leak
>         fixed by: 579dd91ab3a5 nbd: Fix memory leak in nbd_add_socket
> 3c- fb5be6a7b486 2019-09-19  Navid Emamdoost  can: gs_usb: gs_can_open():=
 prevent memory leak
> 3c- 6f3ef5c25cc7 2019-10-25  Navid Emamdoost  wimax: i2400: Fix memory le=
ak in i2400m_op_rfkill_sw_toggle
> 3c- 45c1380358b1 2019-10-27  Navid Emamdoost  ASoC: SOF: ipc: Fix memory =
leak in sof_set_get_large_ctrl_data
> 3c- c0a333d842ef 2019-10-27  Navid Emamdoost  ASoC: SOF: Fix memory leak =
in sof_dfsentry_write
> 3c- 9bbfceea12a8 2019-09-29  Navid Emamdoost  usb: dwc3: pci: prevent mem=
ory leak in dwc3_pci_probe
> 3c- 27d461333459 2019-09-25  Navid Emamdoost  i40e: prevent memory leak i=
n i40e_setup_macvlans
> 3c- 2289adbfa559 2019-10-09  Navid Emamdoost  media: usb: fix memory leak=
 in af9005_identify_state
> 3c- 29cd13cfd762 2019-10-21  Navid Emamdoost  drm/v3d: Fix memory leak in=
 v3d_submit_cl_ioctl
> 3c- c7ed6d0183d5 2019-09-27  Navid Emamdoost  net/mlx5: fix memory leak i=
n mlx5_fw_fatal_reporter_dump
> 3c- c8c2a057fdc7 2019-09-24  Navid Emamdoost  net/mlx5: prevent memory le=
ak in mlx5_fpga_conn_create_cq
> 3c- e0b0cb938864 2019-09-30  Navid Emamdoost  virt: vbox: fix memory leak=
 in hgcm_call_preprocess_linaddr
> 3c- c03b04dcdba1 2019-10-04  Navid Emamdoost  crypto: user - fix memory l=
eak in crypto_reportstat
> 3c- ffdde5932042 2019-10-04  Navid Emamdoost  crypto: user - fix memory l=
eak in crypto_report
> 3c- 9c0530e898f3 2019-09-19  Navid Emamdoost  iio: imu: adis16400: fix me=
mory leak
> 3c- ab612b1daf41 2019-09-19  Navid Emamdoost  iio: imu: adis16400: releas=
e allocated memory on failure
> 3c- 0f4f199443fa 2019-09-27  Navid Emamdoost  iwlwifi: pcie: fix memory l=
eaks in iwl_pcie_ctxt_info_gen3_init
> 3c- b4b814fec1a5 2019-09-12  Navid Emamdoost  iwlwifi: dbg_ini: fix memor=
y leak in alloc_sgtable
> 3c- d10dcb615c8e 2019-10-04  Navid Emamdoost  mwifiex: pcie: Fix memory l=
eak in mwifiex_pcie_init_evt_ring
> 3c- db8fd2cde932 2019-10-04  Navid Emamdoost  mwifiex: pcie: Fix memory l=
eak in mwifiex_pcie_alloc_cmdrsp_buf
> 3c- a7b2df76b42b 2019-09-25  Navid Emamdoost  media: rc: prevent memory l=
eak in cx23888_ir_probe
> 3c- bbe692e349e2 2019-09-16  Navid Emamdoost  rpmsg: char: release alloca=
ted memory
> 3If 1acb8f2a7a9f 2019-10-04  Navid Emamdoost  net: qlogic: Fix memory lea=
k in ql_alloc_large_buffers
>         fixed by: cad46039e4c9 qlogic: Fix error paths in ql_alloc_large_=
buffers()
> 3c- fc739a058d99 2019-09-25  Navid Emamdoost  misc: fastrpc: prevent memo=
ry leak in fastrpc_dma_buf_attach
> 3c- 128c66429247 2019-09-19  Navid Emamdoost  crypto: ccp - Release all a=
llocated memory if sha type is invalid
> 3c- cabe144bfd0c 2019-09-16  Navid Emamdoost  drm/amd/display: memory lea=
k
> 3c- e7883ab63213 2019-09-24  Navid Emamdoost  drm/amd/display: prevent me=
mory leak
> 3c- 055e547478a1 2019-09-16  Navid Emamdoost  drm/amd/display: memory lea=
k
> 3c- a2cdd07488e6 2019-09-19  Navid Emamdoost  rtl8xxxu: prevent leaking u=
rb
> 3c- 34b3be18a04e 2019-09-25  Navid Emamdoost  RDMA/hfi1: Prevent memory l=
eak in sdma_init
> 3c- 3f9361695113 2019-09-24  Navid Emamdoost  rtlwifi: prevent memory lea=
k in rtl_usb_probe
> 3c- d563131ef23c 2019-09-13  Navid Emamdoost  rsi: release skb if rsi_pre=
pare_beacon fails
> 3c- 0e62395da2bd 2019-09-10  Navid Emamdoost  scsi: bfa: release allocate=
d memory in case of error
> 3c- 68501df92d11 2019-09-29  Navid Emamdoost  net: dsa: sja1105: Prevent =
leaking memory
> 3c- 96c5c6e6a5b6 2019-09-20  Navid Emamdoost  tracing: Have error path in=
 predicate_parse() free its allocated memory
> 3c- 6402939ec86e 2019-09-17  Navid Emamdoost  ieee802154: ca8210: prevent=
 memory leak
> 3c- 8ce39eb5a67a 2019-09-25  Navid Emamdoost  nfp: flower: fix memory lea=
k in nfp_flower_spawn_vnic_reprs
> 3c- 8572cea1461a 2019-09-25  Navid Emamdoost  nfp: flower: prevent memory=
 leak in nfp_flower_spawn_phy_reprs
> 3c- a0ecd6fdbf5d 2019-09-24  Navid Emamdoost  drm/komeda: prevent memory =
leak in komeda_wb_connector_add
> 3c- 104c307147ad 2019-09-24  Navid Emamdoost  drm/amd/display: prevent me=
mory leak
> 3c- b8d17e7d93d2 2019-09-19  Navid Emamdoost  ath10k: fix memory leak
> 3c- 4a9d46a9fe14 2019-09-10  Navid Emamdoost  RDMA: Fix goto target to re=
lease the allocated memory
> 3c- a21b7f0cff19 2019-09-11  Navid Emamdoost  net: qrtr: fix memort leak =
in qrtr_tun_write_iter
> 3If 2507e6ab7a9a 2019-09-10  Navid Emamdoost  wimax: i2400: fix memory le=
ak
>         fixed by: 6f3ef5c25cc7 wimax: i2400: Fix memory leak in i2400m_op=
_rfkill_sw_toggle
> 3c- 728c1e2a05e4 2019-09-06  Navid Emamdoost  ath9k: release allocated bu=
ffer if timed out
> 3c- 853acf7caf10 2019-09-06  Navid Emamdoost  ath9k_htc: release allocate=
d buffer if timed out
>
> # Detecting Missing-Check Bugs via Semantic- and Context-Aware Criticalne=
ss and Constraints Inferences
> # https://www-users.cs.umn.edu/~kjlu/papers/crix.pdf
> # Kangjie Lu, Aditya Pakki, Qiushi Wu
> nf- a663e0df4a37 2020-10-07  Mika Westerberg  thunderbolt: Fix memory lea=
k if ida_simple_get() fails in enumerate_services()
> nf- cb7dc3178a98 2020-08-06   Evgeny Novikov  mtd: rawnand: vf610: disabl=
e clk on error handling path in probe
> nf- 66673f96f0f9 2020-07-17         Liu Jian  ieee802154: fix one possibl=
e memleak in adf7242_probe
> nf- 333830aa149a 2020-04-29     Takashi Iwai  gpio: exar: Fix bad handlin=
g for ida_simple_get error path
> 1c- 6fc232db9e8c 2019-12-15     Aditya Pakki  rfkill: Fix incorrect check=
 to avoid NULL pointer dereference
>         https://lore.kernel.org/r/911d4b8d3e9c68860ef4163fc4cce3b5fbb485c=
5.camel@sipsolutions.net
> 2c- 8da96730331d 2019-03-15       Kangjie Lu  ath10k: fix missing checks =
for bmi reads and writes
> 3c- 8dbdee8e8acc 2019-09-11  Navid Emamdoost  media: usb: null check crea=
te_singlethread_workqueue
> 3c- 68085f314d64 2019-09-11  Navid Emamdoost  media: gspca: null check cr=
eate_singlethread_workqueue
> 3c- 4c1fde5077dc 2019-09-11  Navid Emamdoost  platform/chrome: cros_usbpd=
_logger: null check create_singlethread_workqueue
> nc- 864b23f0169d 2019-09-06       Austin Kim  x86/platform/uv: Fix kmallo=
c() NULL check routine
> 3c- d94dfd798c48 2019-08-31  Navid Emamdoost  Bluetooth: bpa10x: change r=
eturn value
> 3c- b95c732234fa 2019-07-24  Navid Emamdoost  mt7601u: null check the all=
ocation
> 3c- 09acf29c8246 2019-07-31  Navid Emamdoost  staging: rtl8192u: null che=
ck the kzalloc
> 3c- afd6d4f5a52c 2019-07-24  Navid Emamdoost  drm/panel: check failure ca=
ses in the probe func
> 3c- bb1320834b8a 2019-07-21  Navid Emamdoost  allocate_flower_entry: shou=
ld check for null deref
> 3c- ea5ab2e422de 2019-07-19  Navid Emamdoost  8250_lpss: check null retur=
n when calling pci_ioremap_bar
> 3c- 3008e06fdf09 2019-07-23  Navid Emamdoost  st_nci_hci_connectivity_eve=
nt_received: null check the allocation
> 3c- 9891d06836e6 2019-07-23  Navid Emamdoost  st21nfca_connectivity_event=
_received: null check the allocation
> 1c- 20d437ee8f48 2019-03-08       Kangjie Lu  net: ixgbevf: fix a missing=
 check of ixgbevf_write_msg_read_ack
>         https://lore.kernel.org/r/YIjzIPuyA0Oz73dJ@kroah.com
> 2c- e08f0761234d 2019-03-22       Kangjie Lu  media: vpss: fix a potentia=
l NULL pointer dereference
> 1IR 23015b22e47c 2019-05-14       Kangjie Lu  rapidio: fix a NULL pointer=
 dereference when create_workqueue() fails
>         https://lore.kernel.org/r/YIhMOAn3XxlB5m2m@kroah.com
> 1IR a2be42f18d40 2019-03-14       Kangjie Lu  ASoC: cs43130: fix a NULL p=
ointer dereference
>         https://lore.kernel.org/r/YIg9ImoNlfuQNOFX@kroah.com
> 1IR 51dd97d1df5f 2019-03-14       Kangjie Lu  ASoC: rt5645: fix a NULL po=
inter dereference
>         https://lore.kernel.org/r/YIg9gESfnZBUALDo@kroah.com
> 1c- d5414c2355b2 2019-03-23     Aditya Pakki  rsi: Fix NULL pointer deref=
erence in kmalloc
>         https://lore.kernel.org/r/YIg9vkwlWw622ZB2@kroah.com
> 1c- 0ed2a0053474 2019-03-12       Kangjie Lu  net: cw1200: fix a NULL poi=
nter dereference
>         https://lore.kernel.org/r/YIhRA6oMozsepir4@kroah.com
> 1c- 22e8860cf8f7 2019-03-24       Kangjie Lu  net: ieee802154: fix missin=
g checks for regmap_update_bits
>         https://lore.kernel.org/r/YIgUGtzV6GSYhCqb@kroah.com
> 1c- 611025983b79 2019-03-11       Kangjie Lu  mmc_spi: add a status check=
 for spi_sync_locked
>         https://lore.kernel.org/r/YIkftQ5YKGVudYk+@pendragon.ideasonboard=
.com
> 2c- d9350f21e5fe 2019-03-22     Aditya Pakki  firmware: arm_scmi: replace=
 of_match_device->data with of_device_get_match_data()
> 1c- 507b820009a4 2019-03-15       Kangjie Lu  PCI: endpoint: Fix a potent=
ial NULL pointer dereference
>         https://lore.kernel.org/r/20210422093111.GA20094@lpieralisi
> 1IR e183d4e414b6 2019-04-11       Kangjie Lu  net/smc: fix a NULL pointer=
 dereference
>         https://lore.kernel.org/r/YIhRvIbPszzavEUU@kroah.com
> 1c- 1adc90c73957 2019-03-12     Aditya Pakki  pinctrl: axp209: Fix NULL p=
ointer dereference after allocation
>         https://lore.kernel.org/r/YIlyGC5U9X+lgK5n@kroah.com
> 2If 6f0ce4dfc5a3 2019-03-18     Aditya Pakki  mtd: rawnand: vf610: Avoid =
a potential NULL pointer dereference
>         fixed by: cb7dc3178a98 mtd: rawnand: vf610: disable clk on error =
handling path in probe
> 1c- 75cf4f5aa903 2019-03-14       Kangjie Lu  power: charger-manager: fix=
 a potential NULL pointer dereference
>         https://lore.kernel.org/r/20210421160248.fveahtwspxa53fft@earth.u=
niverse
> 1c- 536cc27deade 2019-03-16       Kangjie Lu  iio: hmc5843: fix potential=
 NULL pointer dereferences
>         https://lore.kernel.org/r/20210422092625.00005af6@Huawei.com
> 1c- 13814627c965 2019-03-08       Kangjie Lu  iio: adc: fix a potential N=
ULL pointer dereference
>         https://lore.kernel.org/r/20210422093209.00006cc5@Huawei.com
> 2If f0d14edd2ba4 2019-03-15       Kangjie Lu  PCI: rcar: Fix a potential =
NULL pointer dereference
>         removed by: ce351636c67f PCI: rcar: Add suspend/resume
> 1IR 765976285a8c 2019-03-12       Kangjie Lu  rtlwifi: fix a potential NU=
LL pointer dereference
>         https://lore.kernel.org/r/20210427010457.rk7t6p2zs3d2eudn@bryanbr=
attlof.com
> 1c- e5b9b206f3f6 2019-03-12       Kangjie Lu  net: mwifiex: fix a NULL po=
inter dereference
>         https://lore.kernel.org/r/YIjyiWam0Zqq1XMZ@kroah.com
> 2c- 46953f97224d 2019-03-15       Kangjie Lu  brcmfmac: fix missing check=
s for kmemdup
> 2c- 3c77ff8f8bae 2019-03-24       Kangjie Lu  drm/v3d: fix a missing chec=
k of pm_runtime_get_sync
> 1IR 1d84353d205a 2019-04-01       Kangjie Lu  video: imsttfb: fix potenti=
al NULL pointer dereferences
>         https://lore.kernel.org/r/CAL_JsqKoqh=3D-8UHk9JkCgK1fC7bVjVLNehHU=
M=3DR_g6fDan3dHg@mail.gmail.com
> 1IR ec7f6aad57ad 2019-04-01       Kangjie Lu  video: hgafb: fix potential=
 NULL pointer dereference
>         https://lore.kernel.org/r/YIgoFFGLbNZTwPvI@kroah.com
> 1c- 31fa6e2ae65f 2019-04-01     Aditya Pakki  omapfb: Fix potential NULL =
pointer dereference in kmalloc
>         https://lore.kernel.org/r/YIg+juEMf1odL1g4@kroah.com
> 2IR 0aab8e4df470 2019-03-09       Kangjie Lu  leds: pca9532: fix a potent=
ial NULL pointer dereference
>         https://lore.kernel.org/r/YIhEJxEbOSzCm1+Z@kroah.com
> 2c- 8e949363f017 2019-03-19     Aditya Pakki  net: mlx5: Add a missing ch=
eck on idr_find, free buf
> 1c- b5af36e3e5aa 2019-03-14       Kangjie Lu  staging: greybus: audio_man=
ager: fix a missing check of ida_simple_get
> 1c- 699ca3016268 2019-03-25       Kangjie Lu  PCI: xilinx: Check for __ge=
t_free_pages() failure
>         https://lore.kernel.org/r/20210422104224.GB20094@lpieralisi
> 1c- aeb0d0f581e2 2019-03-09       Kangjie Lu  media: video-mux: fix null =
pointer dereferences
>         https://lore.kernel.org/r/YIkioKY+sTEWSv5M@kroah.com
> 2c- fd21b79e541e 2019-03-25     Aditya Pakki  thunderbolt: Fix to check t=
he return value of kmemdup
> 1c- 6183d5a51866 2019-03-25       Kangjie Lu  thunderbolt: property: Fix =
a missing check of kzalloc
>         https://lore.kernel.org/r/20210422112500.GS3511397@lahna.fi.intel=
.com
> 1IR 13bd14a41ce3 2019-03-08       Kangjie Lu  char: hpet: fix a missing c=
heck of ioremap
>         https://lore.kernel.org/r/YIhJg157HZ5mMecS@kroah.com
> 1c- 486fa92df470 2019-03-25     Aditya Pakki  libnvdimm/btt: Fix a kmemdu=
p failure check
>         https://lore.kernel.org/r/CAPcyv4h6SrYg39NN5WzhiXyD3_FjVW4XVXsK=
=3DHUVjWOSPcBaAw@mail.gmail.com
> 1c- 1bbb1c318cd8 2019-03-15       Kangjie Lu  tty: ipwireless: fix missin=
g checks for ioremap
>         https://lore.kernel.org/r/20210421155900.GB7604@twin.jikos.cz
> https://lore.kernel.org/r/dd0698e1-9b31-53fc-4dd1-da474cd483bd@kernel.org
> 1c- e2a438bd7116 2019-03-15       Kangjie Lu  RDMA/i40iw: Handle workqueu=
e allocation failure
>         https://lore.kernel.org/r/20210421140700.GH1370958@nvidia.com
> 2c- 41f00e6e9e55 2019-03-20     Aditya Pakki  usb: usb251xb: fix to avoid=
 potential NULL pointer dereference
> 1c- 3de3dbe7c132 2019-03-19       Kangjie Lu  usb: u132-hcd: fix potentia=
l NULL pointer dereference
>         https://lore.kernel.org/r/YIghqz7ojsUT8NgQ@kroah.com
> 1c- 1a137b47ce6b 2019-03-24       Kangjie Lu  usb: sierra: fix a missing =
check of device_create_file
>         https://lore.kernel.org/r/YIgh+dlg3sqaeeRY@kroah.com
> 1c- fba1bdd2a9a9 2019-03-14       Kangjie Lu  scsi: qla4xxx: fix a potent=
ial NULL pointer dereference
>         https://lore.kernel.org/r/YIhHx42O3FTsL3MS@kroah.com
> 2c- 208c6e8cff1b 2019-03-08       Kangjie Lu  drm: vkms: check status of =
alloc_ordered_workqueue
> 1c- 6cf4511e9729 2019-03-24       Kangjie Lu  gpio: aspeed: fix a potenti=
al NULL pointer dereference
>         https://lore.kernel.org/r/CAMpxmJXn9E7PfRKok7ZyTx0Y+P_q3buArg8YR7=
wV=3D+A9Sid2_Q@mail.gmail.com
> 1c- 55c1fc0af29a 2019-03-12       Kangjie Lu  libnvdimm/namespace: Fix a =
potential NULL pointer dereference
>         https://lore.kernel.org/r/CAPcyv4jkEn0JoT7Ha36-janNC3UfV4OLGzYFc=
=3DFxe5Gh9u_wCQ@mail.gmail.com
> 2If 7ecced0934e5 2019-03-08       Kangjie Lu  gpio: exar: add a check for=
 the return value of ida_simple_get fails
>         fixed by: 333830aa149a gpio: exar: Fix bad handling for ida_simpl=
e_get error path
> 2c- 48f40b96de2c 2019-03-20     Aditya Pakki  thunderbolt: xdomain: Fix t=
o check return value of kmemdup
> 2If 9aabb68568b4 2019-03-20     Aditya Pakki  thunderbolt: Fix to check r=
eturn value of ida_simple_get
>         fixed by: a663e0df4a37 thunderbolt: Fix memory leak if ida_simple=
_get() fails in enumerate_services()
> 2c- 2cc12751cf46 2019-03-20     Aditya Pakki  thunderbolt: Fix to check f=
or kmemdup failure
> 2c- 534c89c22e26 2019-03-14       Kangjie Lu  x86/hyperv: Prevent potenti=
al NULL pointer dereference
> 1c- 2e84f116afca 2019-03-18     Aditya Pakki  x86/hpet: Prevent potential=
 NULL pointer dereference
>         https://lore.kernel.org/r/202104211245.F5FEC8D15D@keescook
> 1c- 7671ce0d9293 2019-03-20     Aditya Pakki  staging: rtl8188eu: Fix pot=
ential NULL pointer dereference of kcalloc
>         https://lore.kernel.org/r/cf31b48e-25b5-bd8a-113e-64dbc96a063b@re=
dhat.com
> 1c- e4dfdd5804cc 2019-03-14       Kangjie Lu  thunderbolt: Fix a missing =
check of kmemdup
>         https://lore.kernel.org/r/20210422113012.GT3511397@lahna.fi.intel=
.com
> 1c- 106204b56f60 2019-03-12       Kangjie Lu  thunderbolt: property: Fix =
a NULL pointer dereference
>         https://lore.kernel.org/r/3821882d-22c4-5dc5-2df9-ae2d5e8fc2a@nam=
ei.org
> 2If d7737d425745 2019-03-18     Aditya Pakki  nfc: Fix to check for kmemd=
up failure
>         fixed by: 7574fcdbdcb3 nfc: fix memory leak in llcp_sock_connect(=
)
> 1IR 63a06181d7ce 2019-03-15       Kangjie Lu  scsi: ufs: fix a missing ch=
eck of devm_reset_control_get
>         https://lore.kernel.org/r/YIg/AqwxTgJsbrVs@kroah.com
> 1c- 6734330654da 2019-03-14       Kangjie Lu  tty: mxs-auart: fix a poten=
tial NULL pointer dereference
>         https://lore.kernel.org/r/1af822a8-2a1b-9110-9832-ba0fe237a1c1@ke=
rnel.org
> 1c- c85be041065c 2019-03-15       Kangjie Lu  tty: atmel_serial: fix a po=
tential NULL pointer dereference
>         https://lore.kernel.org/r/57f44dfa-a502-ee4f-6d53-0ab7cba00e1b@ke=
rnel.org
>         https://lore.kernel.org/r/ad76449f-0603-a156-85d6-37d3c906b4cc@po=
steo.net
> 2c- 3a10e3dd52e8 2019-03-18     Aditya Pakki  serial: max310x: Fix to avo=
id potential NULL pointer dereference
> 1IR 32f47179833b 2019-03-18     Aditya Pakki  serial: mvebu-uart: Fix to =
avoid a potential NULL pointer dereference
>         https://lore.kernel.org/r/20210421130105.1226686-122-gregkh@linux=
foundation.org
> 1c- 6c44b15e1c90 2019-03-14       Kangjie Lu  HID: logitech: check the re=
turn value of create_singlethread_workqueue
>         https://lore.kernel.org/r/nycvar.YFH.7.76.2104211719330.18270@cbo=
bk.fhfr.pm
> 1c- 6d65561f3d5e 2019-03-14       Kangjie Lu  netfilter: ip6t_srh: fix NU=
LL pointer dereferences
>         https://lore.kernel.org/r/20210422212615.GA13017@salvia
> 1c- f37d8e67f39e 2019-03-13     Aditya Pakki  spi : spi-topcliff-pch: Fix=
 to handle empty DMA buffers
>         https://lore.kernel.org/r/YIhK7gCvjuy2KgVX@kroah.com
> 2c- d6cb77228e3a 2019-03-12     Aditya Pakki  pinctrl: baytrail: Fix pote=
ntial NULL pointer dereference
> 2c- 517ccc2aa50d 2019-03-16       Kangjie Lu  net: tipc: fix a missing ch=
eck for nla_nest_start
> 1c- 4589e28db46e 2019-03-15       Kangjie Lu  net: tipc: fix a missing ch=
eck of nla_nest_start
>         https://lore.kernel.org/r/YIj07o8cprfikoHR@kroah.com
> 2c- 07660ca679da 2019-03-15       Kangjie Lu  net: ncsi: fix a missing ch=
eck for nla_nest_start
> 2c- 0fff9bd47e13 2019-03-15       Kangjie Lu  net: openvswitch: fix missi=
ng checks for nla_nest_start
> 1c- 6f19893b644a 2019-03-14       Kangjie Lu  net: openvswitch: fix a NUL=
L pointer dereference
>         https://lore.kernel.org/r/CAOftzPioU8h9b=3DisMPZtE8AYF=3D+qh_nNEp=
3rFEyQmb6Fi7QZ2g@mail.gmail.com
> 1IR dcd0feac9bab 2019-03-14       Kangjie Lu  ALSA: sb8: add a check for =
request_region
>         https://lore.kernel.org/r/s5hbla7a9rt.wl-tiwai@suse.de
> 2c- 6ade657d6125 2019-03-14       Kangjie Lu  ALSA: echoaudio: add a chec=
k for ioremap_nocache
> 1c- 228cd2dba27c 2019-03-14       Kangjie Lu  net: strparser: fix a missi=
ng check for create_singlethread_workqueue
>         https://lore.kernel.org/r/YIj1KKNRKunMPmzN@kroah.com
> 1IR 5bf7295fe34a 2019-03-14     Aditya Pakki  qlcnic: Avoid potential NUL=
L pointer dereference
>         https://lore.kernel.org/r/YIhFCfs0jIRMRgdr@kroah.com
> 1IR a2c6433ee5a3 2019-03-04     Aditya Pakki  ALSA: usx2y: Fix potential =
NULL pointer dereference
>         https://lore.kernel.org/r/s5ha6pra9oo.wl-tiwai@suse.de
> 2If 2795e8c25161 2019-03-11       Kangjie Lu  net: ieee802154: fix a pote=
ntial NULL pointer dereference
>         fixed by: 66673f96f0f9 ieee802154: fix one possible memleak in ad=
f7242_probe
> 2If 4ec850e5dfec 2019-03-12       Kangjie Lu  net: dwmac-sun8i: fix a mis=
sing check of of_get_phy_mode
>         fixed by: 0c65b2b90d13 net: of_get_phy_mode: Change API to solve =
int/unit warnings
> 2If 035a14e71f27 2019-03-12       Kangjie Lu  net: sh_eth: fix a missing =
check of of_get_phy_mode
>         fixed by: 0c65b2b90d13 net: of_get_phy_mode: Change API to solve =
int/unit warnings
> 1c- c7cbc3e937b8 2019-03-12       Kangjie Lu  net: 8390: fix potential NU=
LL pointer dereferences
>         https://lore.kernel.org/r/20210428100844.GA20947@shell.armlinux.o=
rg.uk
> 1IR 9f4d6358e11b 2019-03-12       Kangjie Lu  net: fujitsu: fix a potenti=
al NULL pointer dereference
>         https://lore.kernel.org/r/YIj4mvE9E08Fu6uJ@light.dominikbrodowski=
.net
> 1c- eb32cfcdef23 2019-03-12       Kangjie Lu  net: qlogic: fix a potentia=
l NULL pointer dereference
>         https://lore.kernel.org/r/YIhWPUJgRoh7ENjU@kroah.com
> 2c- 10010493c126 2019-03-12       Kangjie Lu  isdn: hfcpci: fix potential=
 NULL pointer dereference
> 1c- e406f12dde1a 2019-03-04     Aditya Pakki  md: Fix failed allocation o=
f md_register_thread
>         https://lore.kernel.org/r/YIj2nsovH/+ujHL0@kroah.com
> 1c- 5c149314d918 2019-03-11       Kangjie Lu  net: rocker: fix a potentia=
l NULL pointer dereference
>         https://lore.kernel.org/r/YIhV37ufgcw8bpEj@kroah.com
> 1c- 0b31d98d90f0 2019-03-11       Kangjie Lu  net: thunder: fix a potenti=
al NULL pointer dereference
>         https://lore.kernel.org/r/20210423130006.fuh3hljkhkrpcvd3@treble
> 1c- 41af8b3a097c 2019-03-11       Kangjie Lu  net: lio_core: fix two NULL=
 pointer dereferences
>         https://lore.kernel.org/r/YIhVZlxM3vvNX+gV@kroah.com
> 1IR fe543b2f174f 2019-03-11       Kangjie Lu  net: liquidio: fix a NULL p=
ointer dereference
>         https://lore.kernel.org/r/YIhKWhNzv9zIMQJ1@kroah.com
> 1IR d721fe99f6ad 2019-03-08       Kangjie Lu  isdn: mISDNinfineon: fix po=
tential NULL pointer dereference
>         https://lore.kernel.org/r/YIggUIpgRFUbuQXM@kroah.com
> 1IR 38d22659803a 2019-03-02     Aditya Pakki  isdn: mISDN: Fix potential =
NULL pointer dereference of kzalloc
>         https://lore.kernel.org/r/YIghPUPSp9XgjrgK@kroah.com
> 3Ir d1a0846006e4 2019-03-15       Kangjie Lu  security: inode: fix a miss=
ing check for securityfs_create_file
>         reverted by: fe9fd2ef383c Revert "security: inode: fix a missing =
check for securityfs_create_file"
> 2n- f8ee34c3e77a 2019-03-09       Kangjie Lu  media: usbvision: fix a pot=
ential NULL pointer dereference
> 2n- 766460852cfa 2019-03-25       Kangjie Lu  x86/platform/uv: Fix missin=
g checks of kcalloc() return values
> 2n- 78540a259b05 2019-03-22     Aditya Pakki  ASoC: sirf-audio: Remove re=
dundant of_match_node call
> 2n- 6a8ca24590a2 2019-03-20     Aditya Pakki  staging: rtlwifi: Fix poten=
tial NULL pointer dereference of kzalloc
> 2n- d70d70aec963 2019-03-20     Aditya Pakki  staging: rtlwifi: rtl8822b:=
 fix to avoid potential NULL pointer dereference
> 2n- 4280b73092fe 2019-03-11       Kangjie Lu  net: qlge: fix a potential =
NULL pointer dereference
> nf- f87d8ad9233f 2019-01-05 Gustavo A. R. Silva  tipc: fix memory leak in=
 tipc_nl_compat_publ_dump
> 2c- 9c6260de505b 2018-12-24     Aditya Pakki  infiniband/qedr: Potential =
null ptr dereference of qp
> 1c- 92ee77d148bf 2018-12-26       Kangjie Lu  net: marvell: fix a missing=
 check of acpi_match_device
>         https://lore.kernel.org/r/YIglHlva+jlFmItZ@kroah.com
> 2n- 0a54ea9f481f 2018-12-22       Kangjie Lu  staging: rtlwifi: rtl8822b:=
 fix a missing check of alloc_skb
> 2c- eb8950861c1b 2018-12-21       Kangjie Lu  netfilter: nf_tables: fix a=
 missing check of nla_put_failure
> 2If 46273cf7e009 2018-12-26       Kangjie Lu  tipc: fix a missing check o=
f genlmsg_put
>         fixed by: f87d8ad9233f tipc: fix memory leak in tipc_nl_compat_pu=
bl_dump
>
> # Automatically Identifying Security Checks for Detecting Kernel Semantic=
 Bugs
> # Kangjie Lu, Aditya Pakki, and Qiushi Wu
> # https://www-users.cs.umn.edu/~kjlu/papers/cheq.pdf
> nf- 352bcae97f9b 2019-06-07  Rui Nuno Capela  ALSA: ice1712: Check correc=
t return value to snd_i2c_sendbytes (EWS/DMX 6Fire)
> 2c- f4f5748bfec9 2019-06-10     Aditya Pakki  netfilter: ipset: fix a mis=
sing check of nla_parse
> 1c- 0ab34a08812a 2018-12-20       Kangjie Lu  media: si2165: fix a missin=
g check of return value
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 2c- 06d5d6b7f994 2019-04-13       Kangjie Lu  slimbus: fix a potential NU=
LL pointer dereference in of_qcom_slim_ngd_register
> nc- 6b7e5cad651a 2019-03-05   Matthew Wilcox  mm: remove sysctl_extfrag_h=
andler()
> nc- 979eff22c9f4 2019-01-03     Jeff Kirsher  e1000e: fix a missing check=
 for return value
> 1IR 434256833d8e 2019-01-08       Kangjie Lu  libertas: add checks for th=
e return value of sysfs_create_group
>         https://lore.kernel.org/r/YIhNP1RvJzjnLa6e@kroah.com
> nf- 07bd14ccc304 2018-12-26      Wei Yongjun  hwmon: (lm80) Fix missing u=
nlock on error in set_fan_div()
> 1IR 51f689cc1133 2018-12-25       Kangjie Lu  serial: max310x: pass retur=
n value of spi_register_driver
>         https://lore.kernel.org/r/b56966c8-64e2-fee7-4218-4d5db013469b@ke=
rnel.org
> 1c- ff07d48d7bc0 2018-12-25       Kangjie Lu  atl1e: checking the status =
of atl1e_write_phy_reg
>         https://lore.kernel.org/r/YIu6meOO5SSuCW/D@kroah.com
> 1c- 9a20b5e35a53 2018-12-25       Kangjie Lu  rtc: hym8563: fix a missing=
 check of block data read
>         https://lore.kernel.org/r/20210421142831.GB6631@1wt.eu
>         https://lore.kernel.org/r/YIA2cnzudsZJJI+Y@piout.net
> 2n- 5910fa0d0d98 2018-12-25       Kangjie Lu  rtc: coh901331: fix a missi=
ng check of clk_prepare
> 1c- 6f12e46eebf1 2018-12-20       Kangjie Lu  power: twl4030: fix a missi=
ng check of return value
>         https://lore.kernel.org/r/20210421161407.jhcy5gp24z3cko4e@earth.u=
niverse
> 1c- b05ae01fdb89 2018-12-24     Aditya Pakki  misc/ics932s401: Add a miss=
ing check to i2c_smbus_read_word_data
>         https://lore.kernel.org/r/YIhVHBSIaxHFqniM@kroah.com
> 2c- 40619f7dd3ef 2019-01-05     Aditya Pakki  PM: clock_ops: fix missing =
clk_prepare() return value check
> 1IR 248b57015f35 2018-12-25       Kangjie Lu  leds: lp5523: fix a missing=
 check of return value of lp55xx_read
>         https://lore.kernel.org/r/YIq4VD0NyUGv0uy1@kroah.com
> 1IR 467a37fba93f 2018-12-27     Aditya Pakki  media: dvb: Add check on sp=
8870_readreg
>         https://lore.kernel.org/r/YIgSIoBZ7pW78u2d@kroah.com
> 1c- 0f787c12ee7b 2018-12-27     Aditya Pakki  media: dvb: add return valu=
e check on Write16
>         https://lore.kernel.org/r/YIgRvJKbeq4JBW4+@kroah.com
> 1c- 9502cdf08070 2018-12-21       Kangjie Lu  media: mt312: fix a missing=
 check of mt312 reset
>         https://lore.kernel.org/r/YIgQ1Y6uEuIUK27d@kroah.com
> 1c- c9b7d8f252a5 2018-12-20       Kangjie Lu  media: lgdt3306a: fix a mis=
sing check of return value
>         https://lore.kernel.org/r/YIgRUVy51ppj32FT@kroah.com
> 1IR 656025850074 2018-12-28     Aditya Pakki  media: gspca: mt9m111: Chec=
k write_bridge for timeout
>         https://lore.kernel.org/r/YIgQIcBhR4EoPOGM@kroah.com
> 1IR a21a0eb56b4e 2018-12-28     Aditya Pakki  media: gspca: Check the ret=
urn value of write_bridge for timeout
>         https://lore.kernel.org/r/YIgQAYjYQU08gpoI@kroah.com
> 1IR 5b711870bec4 2018-12-25       Kangjie Lu  media: usb: gspca: add a mi=
ssed check for goto_low_power
>         https://lore.kernel.org/r/YIgPbVT+Tj1F9KRE@kroah.com
> 1c- 5ceaf5452c1b 2018-12-25       Kangjie Lu  media: usb: gspca: add a mi=
ssed return-value check for do_command
>         https://lore.kernel.org/r/YIgQi1V/haZOqadM@kroah.com
> 1IR fc6a6521556c 2018-12-26       Kangjie Lu  ath6kl: return error code i=
n ath6kl_wmi_set_roam_lrssi_cmd()
>         https://lore.kernel.org/r/YIhObhA4WpaNAJR7@kroah.com
> 1IR 42daad3343be 2018-12-25       Kangjie Lu  brcmfmac: add a check for t=
he status of usb_register
>         https://lore.kernel.org/r/YIgiOGnU4Nm8L164@kroah.com
> 1c- e85bb0beb649 2019-01-07     Aditya Pakki  Input: ad7879 - add check f=
or read errors in interrupt
>         https://lore.kernel.org/r/YIBa5X+5g/qNL+N8@google.com
> 2If 44fabd8cdaaa 2018-12-25       Kangjie Lu  ASoC: atom: fix a missing c=
heck of snd_pcm_lib_malloc_pages
>         fixed by: 02298145559f ASoC: intel: atom: Use managed buffer allo=
cation
> 1IR beae77170c60 2019-01-06     Aditya Pakki  ALSA: sb: fix a missing che=
ck of snd_ctl_add
>         https://lore.kernel.org/r/s5h8s5ba9jj.wl-tiwai@suse.de
> 2c- 02cc53e223d4 2019-01-06     Aditya Pakki  ALSA: line6: fix check on s=
nd_card_register
> 2If c99776cc4018 2019-01-06     Aditya Pakki  ALSA: ice1712: fix a missin=
g check of snd_i2c_sendbytes
>         fixed by: 352bcae97f9b ALSA: ice1712: Check correct return value =
to snd_i2c_sendbytes (EWS/DMX 6Fire)
> 1IR 0f25e000cb43 2018-12-25       Kangjie Lu  ALSA: gus: add a check of t=
he status of snd_ctl_add
>         https://lore.kernel.org/r/s5h7dkva9go.wl-tiwai@suse.de
> 1c- c8c270240943 2019-01-05     Aditya Pakki  Staging: rts5208: Fix error=
 handling on rtsx_send_cmd
>         https://lore.kernel.org/r/YIhMoRY2tFx3nym5@kroah.com
> 1c- 73b69c01cc92 2018-12-27     Aditya Pakki  staging: rts5208: Add a che=
ck for ms_read_extra_data
>         https://lore.kernel.org/r/YIf7yB/Lfi7HCAVX@kroah.com
> 1Ir 906b40b246b0 2018-12-28     Aditya Pakki  dmaengine: stm32-mdma: Add =
a check on read_u32_array
>         reverted by: 9dfec7ca0ba7 dmaengine: stm32-mdma: Revert "dmaengin=
e: stm32-mdma: Add a check on read_u32_array"
> 1IR a474b3f0428d 2018-12-28     Aditya Pakki  dmaengine: qcom_hidma: Chec=
k for driver register failure
>         https://lore.kernel.org/r/YIgkAw8UVh4F6tQB@kroah.com
> 1c- 7c97381e7a9a 2018-12-24     Aditya Pakki  dmaengine: mv_xor: Fix a mi=
ssing check in mv_xor_channel_add
>         https://lore.kernel.org/r/YIhUlJ/06/A8m9Ft@kroah.com
> 2c- 7fc93f3285b1 2018-12-27     Aditya Pakki  iio: adc: xilinx: check ret=
urn value of xadc_write_adc_reg
> 1c- ae0b3773721f 2018-12-20       Kangjie Lu  iio: ad9523: fix a missing =
check of return value
>         https://lore.kernel.org/r/20210422093505.00006f77@Huawei.com
> 2c- 6ae16dfb61bc 2018-12-24     Aditya Pakki  HID: lenovo: Add checks to =
fix of_led_classdev_register
> 1c- 9e28989d41c0 2018-12-20       Kangjie Lu  mfd: mc13xxx: Fix a missing=
 check of a register-read failure
>         https://lore.kernel.org/r/20210423093042.GE6446@dell
> 1c- 94edd87a1c59 2018-12-26     Aditya Pakki  infiniband: bnxt_re: qplib:=
 Check the return value of send_message
>         https://lore.kernel.org/r/20210421140844.GI1370958@nvidia.com
>         https://lore.kernel.org/r/CANjDDBhAbobpc1nQLoPABCm5onv=3DqVoJXLyG=
79RJwxS=3DcNnijA@mail.gmail.com
> 1c- e49505f7255b 2018-12-25       Kangjie Lu  net: dsa: bcm_sf2: Propagat=
e error value from mdio_write
>         https://lore.kernel.org/r/30b2efa4-f873-a391-00c7-f1eb278a3db1@gm=
ail.com
> 1IR f86a3b83833e 2018-12-25       Kangjie Lu  net: stmicro: fix a missing=
 check of clk_prepare
>         https://lore.kernel.org/r/YIhSzrjLbGqPsfRV@kroah.com
> 1c- 2d822f2dbab7 2018-12-25       Kangjie Lu  net: (cpts) fix a missing c=
heck of clk_prepare
>         https://lore.kernel.org/r/YIhSSEMnGxZfkG94@kroah.com
> 1IR 26fd962bde0b 2018-12-25       Kangjie Lu  niu: fix missing checks of =
niu_pci_eeprom_read
>         https://lore.kernel.org/r/YIkJ72Y7KvLdLwYa@kroah.com
> 1c- ca19fcb6285b 2018-12-24     Aditya Pakki  net: chelsio: Add a missing=
 check on cudg_get_buffer
>         https://lore.kernel.org/r/YIhDUCiM52t1OdY8@kroah.com
> 1c- f0fb9b288d0a 2018-12-24     Aditya Pakki  ipv6/route: Add a missing c=
heck on proc_dointvec
>         https://lore.kernel.org/r/YIhDEacGUekcE1Dx@kroah.com
> 1c- 0eb987c874dc 2018-12-23     Aditya Pakki  net/net_namespace: Check th=
e return value of register_pernet_subsys()
>         https://lore.kernel.org/r/c4cdd3fe-0fd1-c328-14f4-e428eee1d02c@vi=
rtuozzo.com
> 2c- 89dfd0083751 2018-12-23     Aditya Pakki  net/netlink_compat: Fix a m=
issing check of nla_parse_nested
> 1IR 9aa3aa15f4c2 2018-12-21       Kangjie Lu  hwmon: (lm80) fix a missing=
 check of bus read in lm80 probe
>         https://lore.kernel.org/r/78ac6ee8-8e7c-bd4c-a3a7-5a90c7ccb399@ro=
eck-us.net
> 2If c9c63915519b 2018-12-21       Kangjie Lu  hwmon: (lm80) fix a missing=
 check of the status of SMBus read
>         fixed by: 07bd14ccc304 hwmon: (lm80) Fix missing unlock on error =
in set_fan_div()
> 1c- d134e486e831 2018-12-21       Kangjie Lu  net: netxen: fix a missing =
check and an uninitialized use
>         https://lore.kernel.org/r/YIgTlJmdw8MnhTlo@kroah.com
> 2c- cd07e3701fa6 2018-12-21       Kangjie Lu  regulator: tps65910: fix a =
missing check of return value
>         https://lore.kernel.org/r/YIq42bcPgic3y6iQ@kroah.com
> 1c- 966e927bf8cc 2018-12-18       Kangjie Lu  drivers/regulator: fix a mi=
ssing check of return value
>         https://lore.kernel.org/r/YIhC8OhnO04EaTMT@kroah.com
>
> # Check it Again: Detecting Lacking-Recheck Bugs in OS Kernels
> # https://www-users.cs.umn.edu/~kjlu/papers/lrsan.pdf
> # Wenwen Wang, Kangjie Lu, Pen-Chung Yew
> nc- 4a6998aff82a 2018-10-24       Martin Lau  bpf, btf: fix a missing che=
ck bug in btf_parse
> 2c- 7172122be6a4 2018-10-18      Wenwen Wang  crypto: cavium/nitrox - fix=
 a DMA pool free failure
> 1c- b6168562c8ce 2018-10-18      Wenwen Wang  net: socket: fix a missing-=
check bug
>         https://lore.kernel.org/r/YIhClSyv/BKCw619@kroah.com
> 1c- 800a7340ab7d 2018-10-03      Wenwen Wang  dm ioctl: harden copy_param=
s()'s copy_from_user() from malicious users
>         https://lore.kernel.org/r/YIhCwe+FVtgm0LlD@kroah.com
> 2c- 47db7873136a 2018-10-06      Wenwen Wang  scsi: megaraid_sas: fix a m=
issing-check bug
> 2c- 58f5bbe331c5 2018-10-08      Wenwen Wang  ethtool: fix a privilege es=
calation bug
>         https://lore.kernel.org/r/bb8f7b4-ac22-b062-4c59-928513cad0f4@nam=
ei.org
> 1c- 2bb3207dbbd4 2018-10-09      Wenwen Wang  ethtool: fix a missing-chec=
k bug
>         https://lore.kernel.org/r/bbf9a32a-fcb6-2aa9-2f39-ba384be1f5a0@na=
mei.org
> 2n- 6b995f4eec34 2018-10-10      Wenwen Wang  misc: mic: fix a DMA pool f=
ree failure
> 2c- 8af03d1ae2e1 2018-10-07      Wenwen Wang  bpf: btf: Fix a missing che=
ck bug
> 1c- a26ac6c1bed9 2018-10-04      Wenwen Wang  media: isif: fix a NULL poi=
nter dereference bug
>         https://lore.kernel.org/r/YIgOxtlRDsJD/ZwR@kroah.com
> 1c- 0781168e23a2 2018-10-05      Wenwen Wang  yam: fix a missing-check bu=
g
>         https://lore.kernel.org/r/YIhCbigynlBTvbZs@kroah.com
> 1c- 2c05d88818ab 2018-10-05      Wenwen Wang  net: cxgb3_main: fix a miss=
ing-check bug
>         https://lore.kernel.org/r/YIhCV9zg2OgW0kN3@kroah.com
> 2c- f16b613ca8b3 2018-05-18      Wenwen Wang  crypto: chtls - fix a missi=
ng-check bug
> 2n- 6009d1fe6ba3 2018-05-21      Wenwen Wang  isdn: eicon: fix a missing-=
check bug
> 2c- 8e03477cb709 2018-05-05      Wenwen Wang  i2c: core: smbus: fix a pot=
ential missing-check bug
> 1c- bd23a7269834 2018-05-08      Wenwen Wang  virt: vbox: Only copy_from_=
user the request-header once
>         https://lore.kernel.org/r/68067532-56e5-c135-7a7e-0743c8e7b2a0@re=
dhat.com
> 1c- 3f12888dfae2 2018-05-05      Wenwen Wang  ALSA: control: fix a redund=
ant-copy issue
>         https://lore.kernel.org/r/s5h5z0fa9dc.wl-tiwai@suse.de
> 1c- 9899e4d3523f 2018-05-07      Wenwen Wang  scsi: 3w-xxxx: fix a missin=
g-check bug
>         https://lore.kernel.org/r/YIhCLuJi3WyuMS0T@kroah.com
> 1c- c9318a3e0218 2018-05-07      Wenwen Wang  scsi: 3w-9xxx: fix a missin=
g-check bug
>         https://lore.kernel.org/r/b27a43bb-36bc-4b9-42de-c39a5b68f96f@nam=
ei.org
> 2n- dc487321b1e6 2018-04-30      Wenwen Wang  staging: lustre: llite: fix=
 potential missing-check bug when copying lumv
> 1c- d656fe49e33d 2018-04-30      Wenwen Wang  ethtool: fix a potential mi=
ssing-check bug
>         https://lore.kernel.org/r/YIq5PZ9vOKdgcD2R@kroah.com
>
> # Later contributions from Wenwen Wang after UMN.
> nf- a75ca9303175 2020-06-01          yu kuai  block/bio-integrity: don't =
free 'buf' if bio_integrity_add_page() failed
> 3c- f311ade3a7ad 2020-02-01      Wenwen Wang  btrfs: ref-verify: fix memo=
ry leaks
> 3c- 123c23c6a7b7 2020-02-03      Wenwen Wang  NFS: Fix memory leaks
> 3c- fa865ba183d6 2020-01-25      Wenwen Wang  firestream: fix memory leak=
s
> 3c- 8472ba621540 2019-08-12      Wenwen Wang  e1000: fix memory leaks
> 3Ir 334f5b61a6f2 2019-08-15      Wenwen Wang  ath10k: add cleanup in ath1=
0k_sta_state()
>         f4fe2e53349f ath10k: Revert "ath10k: add cleanup in ath10k_sta_st=
ate()"
> 3c- 137e92fd1495 2019-08-18      Wenwen Wang  mtd: sm_ftl: Fix memory lea=
k in sm_init_zone() error path
> 3c- 6a379f67454a 2019-08-19      Wenwen Wang  jffs2: Fix memory leak in j=
ffs2_scan_eraseblock() error path
> 3Ir 9163e0184bd7 2019-08-19      Wenwen Wang  ubifs: Fix memory leak bug =
in alloc_ubifs_info() error path
>         reverted by: 91cbf01178c3 Revert "ubifs: Fix memory leak bug in a=
lloc_ubifs_info() error path"
> 3c- 7992e00469c4 2019-08-19      Wenwen Wang  ubifs: Fix memory leak in _=
_ubifs_node_verify_hmac error path
> 3c- ce4d8b16e64d 2019-08-19      Wenwen Wang  ubifs: Fix memory leak in r=
ead_znode() error path
> 3c- 22d11eacc32c 2019-08-11      Wenwen Wang  ixgbe: fix memory leaks
> 3c- 145a32fe57e3 2019-08-15      Wenwen Wang  airo: fix memory leaks
> 3c- 29b49958cf73 2019-08-20      Wenwen Wang  ACPI / PCI: fix acpi_pci_ir=
q_enable() memory leak
> 3IR 03d1571d9513 2019-08-16      Wenwen Wang  ACPI: custom_method: fix me=
mory leaks
> 3c- e027a2dea5fd 2019-08-19      Wenwen Wang  hwmon (coretemp) Fix a memo=
ry leak bug
> 3c- 6ca5989e44d3 2019-08-18      Wenwen Wang  media: ti-vpe: Add cleanup =
in vpdma_list_cleanup()
> 3c- 51d47e578a74 2019-08-18      Wenwen Wang  media: fdp1: Fix a memory l=
eak bug
> 3c- 42e64117d3b4 2019-08-18      Wenwen Wang  media: saa7146: add cleanup=
 in hexium_attach()
> 3c- 725a28290a53 2019-08-17      Wenwen Wang  media: usb: cx231xx-417: fi=
x a memory leak bug
> 3c- 1c770f0f52dc 2019-08-17      Wenwen Wang  media: cpia2_usb: fix memor=
y leaks
> 3c- 86aa04f4c221 2019-08-18      Wenwen Wang  mtd: rawnand: Fix a memory =
leak bug
> 3c- d83aef09aaa5 2019-08-18      Wenwen Wang  mtd: onenand_base: Fix a me=
mory leak bug
> 3c- de0e4fd2f07c 2019-08-20      Wenwen Wang  qed: Add cleanup in qed_slo=
wpath_start()
> 3c- fcd5ce4b3936 2019-08-18      Wenwen Wang  media: dvb-core: fix a memo=
ry leak bug
> 3c- 2f6451ed8b52 2019-08-17      Wenwen Wang  media: dvb-frontends: fix a=
 memory leak bug
> 3c- 8c3d3cdbd5dd 2019-08-17      Wenwen Wang  media: dvb-frontends: fix m=
emory leaks
> 3c- 1e672e364494 2019-08-20      Wenwen Wang  NFSv4: Fix a memory leak bu=
g
> 3c- dc1a3e8e0cc6 2019-08-18      Wenwen Wang  dm raid: add missing cleanu=
p in raid_ctr()
> 3c- 313aca5a9c78 2019-08-19      Wenwen Wang  mtd: spi-nor: fix a memory =
leak bug
> 3c- 60e2dde1e91a 2019-08-19      Wenwen Wang  led: triggers: Fix a memory=
 leak bug
> 3c- 2323d7baab2b 2019-08-18      Wenwen Wang  infiniband: hfi1: fix memor=
y leaks
> 3c- b08afa064c32 2019-08-18      Wenwen Wang  infiniband: hfi1: fix a mem=
ory leak bug
> 3c- 5c1baaa82cea 2019-08-18      Wenwen Wang  IB/mlx4: Fix memory leaks
> 3c- 962411b05a6d 2019-08-16      Wenwen Wang  dmaengine: ti: omap-dma: Ad=
d cleanup in omap_dma_probe()
> 3c- 2c231c0c1dec 2019-08-16      Wenwen Wang  dmaengine: ti: dma-crossbar=
: Fix a memory leak bug
> 3c- cfddf9f4c9f0 2019-08-19      Wenwen Wang  locks: fix a memory leak bu=
g in __break_lease()
> 3c- b4a81b87a4cf 2019-08-20      Wenwen Wang  ecryptfs: fix a memory leak=
 bug in ecryptfs_init_messaging()
> 3c- fe2e082f5da5 2019-08-20      Wenwen Wang  ecryptfs: fix a memory leak=
 bug in parse_tag_1_packet()
> 3c- 44ef3a032528 2019-08-15      Wenwen Wang  wimax/i2400m: fix a memory =
leak bug
> 3c- f1472cb09f11 2019-08-14      Wenwen Wang  net: kalmia: fix memory lea=
ks
> 3c- 1eca92eef187 2019-08-14      Wenwen Wang  cx82310_eth: fix a memory l=
eak bug
> 3c- b9cbf8a64865 2019-08-14      Wenwen Wang  lan78xx: Fix memory leaks
> 3c- 20fb7c7a39b5 2019-08-14      Wenwen Wang  net: myri10ge: fix memory l=
eaks
> 3c- 6f967f8b1be7 2019-08-14      Wenwen Wang  liquidio: add cleanup in oc=
teon_setup_iq()
> 3c- c554336efa9b 2019-08-13      Wenwen Wang  cxgb4: fix a memory leak bu=
g
> 3c- 48ec7014c56e 2019-08-12      Wenwen Wang  net/mlx4_en: fix a memory l=
eak bug
> 3c- ae78ca3cf3d9 2019-08-11      Wenwen Wang  xen/blkback: fix memory lea=
ks
> 3c- 7afe9a4e5665 2019-08-11      Wenwen Wang  i3c: master: fix a memory l=
eak bug
> 3c- cfef67f016e4 2019-08-09      Wenwen Wang  ALSA: hda - Fix a memory le=
ak bug
> 3c- 1be3c1fae6c1 2019-08-08      Wenwen Wang  ALSA: firewire: fix a memor=
y leak bug
> 3c- c7cd7c748a32 2019-08-08      Wenwen Wang  sound: fix a memory leak bu=
g
> 3c- 3d92aa45fbfd 2019-08-07      Wenwen Wang  ALSA: hiface: fix multiple =
memory leak bugs
> 3c- a67060201b74 2019-08-06      Wenwen Wang  ALSA: usb-audio: fix a memo=
ry leak bug
> 3c- d4fddac5a51c 2019-07-14      Wenwen Wang  test_firmware: fix a memory=
 leak bug
> 3c- 45004d66f2a2 2019-07-22      Wenwen Wang  ASoC: dapm: fix a memory le=
ak bug
> 3c- 15a78ba1844a 2019-07-20      Wenwen Wang  netfilter: ebtables: fix a =
memory leak bug in compat
> 3If e7bf90e5afe3 2019-07-11      Wenwen Wang  block/bio-integrity: fix a =
memory leak bug
>         fixed by: a75ca9303175 "block/bio-integrity: don't free 'buf' if =
bio_integrity_add_page() failed"
>
> # Earlier contributions from Kangjie Lu before UMN.
> nf- 55e77a3e8297 2016-07-01     Richard Alpe  tipc: fix nl compat regress=
ion for link statistics
> 3c- 4116def23379 2016-06-02       Kangjie Lu  rds: fix an infoleak in rds=
_inc_info_copy
> 3If 5d2be1422e02 2016-06-02       Kangjie Lu  tipc: fix an infoleak in ti=
pc_nl_compat_link_dump
>         fixed by: 55e77a3e8297 tipc: fix nl compat regression for link st=
atistics
> 3c- 79e48650320e 2016-05-08       Kangjie Lu  net: fix a kernel infoleak =
in x25 module
> 3c- e4ec8cc8039a 2016-05-03       Kangjie Lu  ALSA: timer: Fix leak in ev=
ents via snd_timer_user_tinterrupt
> 3c- 9a47e9cff994 2016-05-03       Kangjie Lu  ALSA: timer: Fix leak in ev=
ents via snd_timer_user_ccallback
> 3c- cec8f96e49d9 2016-05-03       Kangjie Lu  ALSA: timer: Fix leak in SN=
DRV_TIMER_IOCTL_PARAMS
> 3c- 5f8e44741f9f 2016-05-03       Kangjie Lu  net: fix infoleak in rtnetl=
ink
> 3c- b8670c09f37b 2016-05-03       Kangjie Lu  net: fix infoleak in llc
> 3c- d13829686bba 2016-05-03       Kangjie Lu  staging: wilc1000: fix info=
leak in wilc_wfi_cfgoperations
>
> # UAF fixes seemingly not associated with known UMN papers.
> 1Ia 0c85a7e87465 2021-04-06     Aditya Pakki  net/rds: Avoid potential us=
e after free in rds_send_remove_from_sock
>         reverted by: 799bac551218 Revert "net/rds: Avoid potential use af=
ter free in rds_send_remove_from_sock"
> 3c- c54d481d71c6 2019-10-21  Navid Emamdoost  apparmor: Fix use-after-fre=
e in aa_audit_rule_init
>
> # Memory disclosure fixes seemingly not associated with other UMN papers.
> 1IR d39083234c60 2019-10-18       Kangjie Lu  media: rcar_drif: fix a mem=
ory disclosure
>         https://lore.kernel.org/r/20210422110336.1d67678d@coco.lan
> 1c- ec3b7b6eb8c9 2019-10-17       Kangjie Lu  drm/gma500: fix memory disc=
losures due to uninitialized bytes
>         https://lore.kernel.org/r/20210429202301.GI31692@amd
> 1c- 57a25a5f754c 2019-10-17       Kangjie Lu  gma/gma500: fix a memory di=
sclosure bug due to uninitialized bytes
>         https://lore.kernel.org/r/CAKMK7uF6sWeKX0DAaXoT9=3DxkD9eAAjHtkE0g=
n+v9YxmYAd3vdg@mail.gmail.com
>
> # Memory leak fixes seemingly not associated with k-meld nor hero.
> nc- fe6c6a4af2be 2020-08-25      Dinghao Liu  video: fbdev: radeon: Fix m=
emleak in radeonfb_pci_register
> 1c- cbb88db76a15 2019-04-29      Wenwen Wang  ALSA: usx2y: fix a double f=
ree bug
>         https://lore.kernel.org/r/s5hczunaa54.wl-tiwai@suse.de
> 2c- cb5173594d50 2019-04-27      Wenwen Wang  ALSA: usb-audio: Fix a memo=
ry leak bug
> 1c- 91862cc7867b 2019-04-19      Wenwen Wang  tracing: Fix a memory leak =
by early error exit in trace_pid_write()
>         https://lore.kernel.org/r/20210421092919.2576ce8d@gandalf.local.h=
ome
> 1c- 70c4cf17e445 2019-04-19      Wenwen Wang  audit: fix a memory leak bu=
g
>         https://lore.kernel.org/r/CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_=
EsgZx3coM8oA@mail.gmail.com
> 1c- ea094d53580f 2019-04-17      Wenwen Wang  x86/PCI: Fix PCI IRQ routin=
g table memory leak
>         https://lore.kernel.org/r/20210422050919.GA2913711@bjorn-Precisio=
n-5520
> 1c- 39416c5872db 2019-04-15      Wenwen Wang  udf: fix an uninitialized r=
ead bug and remove dead code
>         https://lore.kernel.org/r/20210421135533.GV8706@quack2.suse.cz
> 1IR 093c48213ee3 2018-12-26      Wenwen Wang  gdrom: fix a memory leak bu=
g
>         https://lore.kernel.org/r/23ffd3c5-0095-6a95-8c30-2b6f67377ce7@ax=
entia.se
> 2n- 15b3048aeed8 2018-12-04      Wenwen Wang  misc: mic: fix a DMA pool f=
ree failure
>
> # "touched it last" CC of UMN author.
> no- c96da175ba88 2020-11-28     Sam Ravnborg  video: fbdev: omapfb: Fix s=
et but not used warnings in dsi
>
> # Much older UMN commits unrelated to the UMN research group.
> 3o- 23779fbc9930 2013-10-23 Alireza Haghdoost  block: Enable sysfs nomerg=
e control for I/O requests in the plug list
> 3o- ae0fda0cdf00 2006-07-06  Dave C Boutcher  [SCSI] ibmvscsi: handle ina=
ctive SCSI target during probe
> 3o- 6c51fe10475e 2006-07-06  Dave C Boutcher  [SCSI] ibmvscsi: allocate l=
pevents for ibmvscsi on iseries
> 3o- cefbda2d6cd9 2006-06-12  Dave C Boutcher  [SCSI] ibmvscsi: treat busy=
 and error conditions separately
> 3o- 368a6ba5d188 2006-06-12  Dave C Boutcher  [POWERPC] check firmware st=
ate before suspending
> 3o- 9b833e428ad2 2006-03-23  Dave C Boutcher  [SCSI] ibmvscsi: prevent sc=
si commands being sent in invalid state
> 3o- b4fd884a037c 2006-02-03  Dave C Boutcher  [PATCH] powerpc: remove use=
less call to touch_softlockup_watchdog
> 3o- 82a4df74628a 2006-02-03  Dave C Boutcher  [PATCH] powerpc: prod all p=
rocessors after ibm,suspend-me
> 3o- c4cb8ecca66e 2006-02-03  Dave C Boutcher  [PATCH] powerpc: return cor=
rect rtas status from ibm,suspend-me
>
>
> Moving forward
>
> The Linux kernel was started by a university student, and there have
> been strong ties between the kernel and academic communities ever since.
> This collaboration is beneficial both to Linux, which gains from the work
> and ideas of researchers, and to the research community, which is able to
> work with a heavily used kernel and see its ideas deployed in practice.
> This collaboration is worth preserving -- and, indeed deepening.  The
> incident described in this paper is seen by some developers in both camps
> as a threat to that collaboration, but it need not turn out that way.
>
> We have two specific recommendations designed to ensure that the kernel
> project and UMN can continue to work together successfully in the future:
>
>  - UMN must improve the quality of the changes that are proposed for
>    inclusion into the kernel, and
>
>  - The TAB, working with researchers, will create a document explaining
>    best practices for all research groups to follow when working with the
>    kernel (and open-source projects in general).
>
> The combination of these two changes, we hope, will help the kernel and
> research communities to work together fruitfully and prevent incidents
> like this from occurring again.
>
> Development process changes
>
> In the past, the kernel community has often had to deal with a pattern
> of low-quality patches originating from a single company or group.
> These patches consume scarce maintainer time and, over time, lead to tens=
e
> relations between the two groups.  In such cases, the kernel community
> has worked with the companies involved to set up internal procedures to
> make the patch creation and submission process work better.  When set
> up properly, such a process can reduce the mentoring load on kernel
> maintainers and enable contributors to be more successful in their work.
>
> A common practice in many companies is to designate a set of experienced
> internal developers to review and provide feedback on proposed kernel
> changes before those changes are submitted publicly.  This review catches
> obvious mistakes and relieves the community of the need to repeatedly
> remind developers of elementary practices like adherence to coding
> standards and thorough testing of patches.  It results in a higher-qualit=
y
> patch stream that will encounter fewer problems in the kernel community.
>
> We believe that UMN could benefit from a review process of this type, and
> recommend that UMN find at least one experienced developer to fill this
> role.  Having such a reviewer in place could have prevented the submissio=
n
> of many of the flawed patches described here.  Working with an experience=
d
> developer can also help UMN researchers toward better interactions with
> the kernel community and would, hopefully, prevent concepts like the
> "Hypocrite Commits" project from getting beyond the idea stage.
>
> Until such a review process is put into place, it will be difficult to
> re-establish the trust between UMN and the kernel community, and patches
> from UMN will continue to find a chilly reception.  If UMN needs help
> to find such a developer or to set up an internal review process, the
> TAB will be glad to assist.  This is a role the TAB has played with many
> groups in the past.
>
> Best practices for research institutions
>
> This incident has highlighted the differences in the motivations behind
> the kernel development and research communities.  While both groups
> are interested in making a better kernel for the massive user community,
> kernel developers tended to be focused on engineering processes, reviewin=
g
> contributions, and mentoring new contributors, while researchers tend
> to be focused on exploring new ideas and methodologies, developing new
> tools, and furthering their understanding of how development communities
> interact.  There is a lot of value created by both groups, but they can
> also occasionally lead to conflict.
>
> The kernel community welcomes the help and participation of the research
> community; we know it makes us stronger and more effective.  But this
> work must also help with the community's goal of creating a robust kernel
> for production use.  When interactions with researchers are seen to only
> benefit the research side while imposing costs on the kernel community,
> friction can result.  Examples include posting patches from tools that ar=
e
> not ready for a production code base or deliberately trying to subvert th=
e
> patch-review process.
>
> To avoid this friction, to prevent incidents like the one described here
> from happening again, and to encourage better interaction between the two
> communities in general, the TAB will be working with researchers (to be
> named soon) to develop a document describing a set of best practices
> for researchers to follow when working with the kernel community.  This
> will be a living document, maintained in the kernel documentation tree
> and evolved over time as needed.  Any researchers who would like to
> participate in this effort are encouraged to contact the TAB to express
> their interest.
>
>
> Thanks
>
> The TAB would like to thank the following kernel developers for helping
> with this unexpected re-review of the prior UMN kernel commits.  They
> were gracious to give their time to do this work to for the kernel
> community:
>         Al Viro
>         Alaa Emad
>         Alex Williamson
>         Alexander Deucher
>         Alexandre Belloni
>         Alexei Starovoitov
>         Anirudh Rayabharam
>         Ard Biesheuvel
>         Atul Gopinathan
>         Bart Van Assche
>         Bartosz Golaszewski
>         Bjorn Helgaas
>         Borislav Petkov
>         Bryan Brattlof
>         Daniel Borkmann
>         Daniel Vetter
>         David Howells
>         David Sterba
>         Devesh Sharma
>         Dmitry Torokhov
>         Dominik Brodowski
>         Doug Ledford
>         Du Cheng
>         Enric Balletbo
>         Fabrizio Castro
>         Fatih Yildirim
>         Felipe Balbi
>         Felix Kuehling
>         Florian Fainelli
>         Geert Uytterhoeven
>         Guenter Roeck
>         Hans Verkuil
>         Hans de Goede
>         J. Bruce Fields
>         Jakub Kicinski
>         James Morris
>         Jan Kara
>         Jason Gunthorpe
>         Jens Axboe
>         Jiri Kosina
>         Jiri Slaby
>         Joe Stringer
>         Joerg Roedel
>         Johannes Berg
>         Jonathan Cameron
>         Josh Poimboeuf
>         Juergen Gross
>         Julia Lawall
>         Kalle Valo
>         Kirill Tkhai
>         Krzysztof Kozlowski
>         Kurt Manucredo
>         Laurent Pinchart
>         Lee Jones
>         Linus Walleij
>         Lorenzo Pieralisi
>         Matteo Croce
>         Mauro Carvalho Chehab
>         Mika Westerberg
>         Pablo Neira Ayuso
>         Paul Moore
>         Pavel Machek
>         Peter Rosin
>         Phillip Potter
>         Rafael J. Wysocki
>         Richard Genoud
>         Richard Guy Briggs
>         Rob Herring
>         Robert Foss
>         Roland Dreier
>         Russell King
>         Sebastian Reichel
>         Shuah Khan
>         Sinan Kaya
>         Song Liu
>         Stefan Schmidt
>         Takashi Iwai
>         Tariq Toukan
>         Tavis Ormandy
>         Thomas Gleixner
>         Tom Seewald
>         Tyler Hicks
>         Ulf Hansson
>         Viresh Kumar
>         Willy Tarreau



--=20
Kangjie Lu
Assistant Professor
Department of Computer Science and Engineering
University of Minnesota
https://www-users.cs.umn.edu/~kjlu

