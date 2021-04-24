Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7176136A386
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhDXWcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 18:32:05 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57052 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhDXWcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 18:32:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4FSQqd1LfLz9vBrx
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 22:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lteTLIebVBmc for <linux-kernel@vger.kernel.org>;
        Sat, 24 Apr 2021 17:31:25 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4FSQqc6XDQz9vBs4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 17:31:24 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4FSQqc6XDQz9vBs4
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4FSQqc6XDQz9vBs4
Received: by mail-il1-f198.google.com with SMTP id i27-20020a056e021d1bb02901699edaa0aaso24349898ila.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zCunM/hYfe91NvKoX6G06aHdGfHkFfqRfVFZCOkxZoI=;
        b=RbrQbValoLUrgKQpBQ+q0UDKJywLqxeUJIojaKCOcDoLxICVe9SwvcNViYu1zm+Jxr
         FecBLWvHv+bfqcnzdwnWUUQEvFSQNSq9G8ghPjxi5A3GANraklPY/EKLVRtHw7pONDMc
         aD4NuPrf9iH8nuiEa5H+o2FJcA2wCkNgJOCGy+a7sTMtMjvP3Q88edmgGW9ADeWF4Xm+
         O5cZKQbDMsZxvwCm3vYqOABV6rtYs+5sadY4Jm77oRMUT2SsBeBNyVzxAbccqll1E7xH
         r6TnMIuKP3HBPDaw7i/bDLByZjOZo7SjehNSZT0HvNh2bIg2GkevsPsHraSGAElBoXee
         I+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zCunM/hYfe91NvKoX6G06aHdGfHkFfqRfVFZCOkxZoI=;
        b=fhah6nT6+FTuou98rMA9kJX3J5R4i/SwHOt7mtlnye0j9QHhytkKsEnDnLrDswyiMm
         i7Va/y4A2Nmi5gFEJu8Rdf8OYzy9iq7N25TmAQJMzpHpEXnmzqThHxWV3nt2KtaEHhxM
         3+zaZ4Kw1k+rjvB/CcXJO+AY/traEw4h5rAgouHoKRWE1GQCnu/SedsPS+oS0iReJc5W
         CudaS+Muz3saDXtpRTJ1q1lnSzY+tkZLy/2M2D8qOqtYjZHtZXTYro1ykRYXLkgZe64V
         tEEVmJUakxFfHxpUAIdtned3h1jjAKgKZxJjN6hsqp+u8oMNgrZTenI897n+2YS0H6FG
         c2UQ==
X-Gm-Message-State: AOAM531E41wukwcT98UNwAaNc+bETFeEBsK4A5MzdBxRHS64fR0ntZqp
        /xbHwFcxxOAj9elJzZONUAVCmusCmZqce5itnD2Drduld7Y6LKS1Ok/8WpWuuOB+3JVCZ2wqfaD
        NLdbisnAAIBACXDxp64svUeQ7049TDSqA3YM8fc2CoQd7
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr8093537iok.117.1619303484260;
        Sat, 24 Apr 2021 15:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZu69tUyH06XP4SVb+BKgaHsV3zmeskqkHd4WtzuNT87lhuZbW40ee9lWbJBwmIhH8tu4eh1aO0seEeavXshc=
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr8093518iok.117.1619303484019;
 Sat, 24 Apr 2021 15:31:24 -0700 (PDT)
MIME-Version: 1.0
From:   Kangjie Lu <kjlu@umn.edu>
Date:   Sat, 24 Apr 2021 17:30:50 -0500
Message-ID: <CAK8KejpUVLxmqp026JY7x5GzHU2YJLPU8SzTZUNXU2OXC70ZQQ@mail.gmail.com>
Subject: An open letter to the Linux community
To:     open list <linux-kernel@vger.kernel.org>
Cc:     Qiushi Wu <wu000273@umn.edu>, Aditya Pakki <pakki001@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

April 24, 2021
An open letter to the Linux community

Dear Community Members:

We sincerely apologize for any harm our research group did to the
Linux kernel community. Our goal was to identify issues with the
patching process and ways to address them, and we are very sorry that
the method used in the =E2=80=9Chypocrite commits=E2=80=9D paper was inappr=
opriate. As
many observers have pointed out to us, we made a mistake by not
finding a way to consult with the community and obtain permission
before running this study; we did that because we knew we could not
ask the maintainers of Linux for permission, or they would be on the
lookout for the hypocrite patches. While our goal was to improve the
security of Linux, we now understand that it was hurtful to the
community to make it a subject of our research, and to waste its
effort reviewing these patches without its knowledge or permission.

We just want you to know that we would never intentionally hurt the
Linux kernel community and never introduce security vulnerabilities.
Our work was conducted with the best of intentions and is all about
finding and fixing security vulnerabilities.

The =E2=80=9Chypocrite commits=E2=80=9D work was carried out in August 2020=
; it aimed
to improve the security of the patching process in Linux. As part of
the project, we studied potential issues with the patching process of
Linux, including causes of the issues and suggestions for addressing
them.
* This work did not introduce vulnerabilities into the Linux code. The
three incorrect patches were discussed and stopped during exchanges in
a Linux message board, and never committed to the code. We reported
the findings and our conclusions (excluding the incorrect patches) of
the work to the Linux community before paper submission, collected
their feedback, and included them in the paper.
* All the other 190 patches being reverted and re-evaluated were
submitted as part of other projects and as a service to the community;
they are not related to the =E2=80=9Chypocrite commits=E2=80=9D paper.
* These 190 patches were in response to real bugs in the code and all
correct--as far as we can discern--when we submitted them.
* We understand the desire of the community to gain access to and
examine the three incorrect patches. Doing so would reveal the
identity of members of the community who responded to these patches on
the message board. Therefore, we are working to obtain their consent
before revealing these patches.
* Our recent patches in April 2021 are not part of the =E2=80=9Chypocrite
commits=E2=80=9D paper either. We had been conducting a new project that ai=
ms
to automatically identify bugs introduced by other patches (not from
us). Our patches were prepared and submitted to fix the identified
bugs to follow the rules of Responsible Disclosure, and we are happy
to share details of this newer project with the Linux community.

We are a research group whose members devote their careers to
improving the Linux kernel. We have been working on finding and
patching vulnerabilities in Linux for the past five years. The past
observations with the patching process had motivated us to also study
and address issues with the patching process itself. This current
incident has caused a great deal of anger in the Linux community
toward us, the research group, and the University of Minnesota. We
apologize unconditionally for what we now recognize was a breach of
the shared trust in the open source community and seek forgiveness for
our missteps.

We seek to rebuild the relationship with the Linux Foundation and the
Linux community from a place of humility to create a foundation from
which, we hope, we can once again contribute to our shared goal of
improving the quality and security of Linux software. We will work
with our department as they develop new training and support for
faculty and students seeking to conduct research on open source
projects, peer-production sites, and other online communities.  We are
committed to following best practices for collaborative research by
consulting with community leaders and members about the nature of our
research projects, and ensuring that our work meets not only the
requirements of the IRB but also the expectations that the community
has articulated to us in the wake of this incident.

While this issue has been painful for us as well, and we are genuinely
sorry for the extra work that the Linux kernel community has
undertaken, we have learned some important lessons about research with
the open source community from this incident. We can and will do
better, and we believe we have much to contribute in the future, and
will work hard to regain your trust.


Sincerely,


Kangjie Lu, Qiushi Wu, and Aditya Pakki
University of Minnesota
