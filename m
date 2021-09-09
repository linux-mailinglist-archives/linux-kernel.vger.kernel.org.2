Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9A405BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhIIRDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhIIRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:03:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C865C061574;
        Thu,  9 Sep 2021 10:02:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k4so5011319lfj.7;
        Thu, 09 Sep 2021 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIfAoo/G7Fm3X9NrBjLmLLwUCDjhAIFe7S1HChy8r6w=;
        b=QDi8VF84qL0gTU0hXRG7TTZsVQnC9kV+gq5Zqn9AfAnhX0+OV+3lmh4BNhe+3fQTFP
         nE3Gsvxq9GBhXO17w1yH0sOPKk+vKjKHXWxPVR2H0lhK9U/ROsbakAk//+sy+u7jyR2T
         OxfVN0ERZ0iJUWoyMnnQ9wp77ZvhL7MMw0ZfeNiDdPgwTk7QnPit8aJov1qOa6HugRS7
         Tt6J3fUZzfs+9GHbzQ18eyBVrX6nhxmsDjoP2NBet+amu6XLz5c5DbXgjDkdFy8TB7Zk
         K69rOeyZOmJR496VrWiF7KfqzHC3mjed+TZeJWHUZULDSGDns8/hbl61+ljy27gfWJq+
         Uo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIfAoo/G7Fm3X9NrBjLmLLwUCDjhAIFe7S1HChy8r6w=;
        b=KiY97BcanYToJ6hsAdWp9MPshBZmNr6aNUxx5sOWFYxj7MfQ4in3uhYtSAr+dVE56A
         SmB4I/PJ6cCJ4HWiWLRh3nK3A96jLl7KFF5f4R0njOjC+f+ECKK1KOr7KM7cf/QKJoYp
         9tzj4DzsjqUXVwa4d2WNWOk1Nh1z/QX/RRKFUq/8/AN/2HSUiHsSRpu+bqCIfhf6DP/9
         SyUIYixYTAcwPKBeHUc5tuks6ZX9lbrLaX1rNvZ8kfVn9q5pE7FyApRZvlAnWC1NfOJO
         XmEPmVNV10Gx65Tpt6jIZlXvkCBCpOqUc7KfVPkO1zrxDrPkc+PeWnWfXrqq68Ymd/65
         8gwQ==
X-Gm-Message-State: AOAM531nnFQZQwoqVTRTW079OBtzCaLK4yXfRn8JkunbrQZiQEresJod
        mYcxJNXEd4sy/sqf3DpV5CNSFlA74G+2lqgx0gHeC8RbYJ4=
X-Google-Smtp-Source: ABdhPJzP+qiRIiROtZIfG+kvHtX+hjXAXXdSnX6Fw2qxDi389joenwUV15vAxO1x9CCCiIt5+HrBkmlEZ4vp5i267JU=
X-Received: by 2002:a05:6512:ac4:: with SMTP id n4mr615817lfu.237.1631206955640;
 Thu, 09 Sep 2021 10:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMyRKM9Ev_Yyyup-T=AZe2aYcN-ZneXsLmHtUC7as67zNQ@mail.gmail.com>
 <20210904082330.14864-1-utkarshverma294@gmail.com>
In-Reply-To: <20210904082330.14864-1-utkarshverma294@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 9 Sep 2021 22:32:23 +0530
Message-ID: <CABJPP5DyppeW=_XXJKn_NnQahOn=k0oBi-dDdcyxN8rygwusEw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: checkpatch: Add SYMBOLIC_PERMS message
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 1:53 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> Add a new message type SYMBOLIC_PERMS under the 'Permissions'
> subsection. Octal permission bits are easier to read and understand
> instead of their symbolic macro names.
>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index f0956e9ea2d8..41037594ec24 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -957,6 +957,17 @@ Permissions
>      Permission bits should use 4 digit octal permissions (like 0700 or 0444).
>      Avoid using any other base like decimal.
>
> +  **SYMBOLIC_PERMS**
> +    Permission bits in the octal form are more readable and easier to
> +    understand than their symbolic counterparts because many command-line
> +    tools use this notation only. Experienced kernel developers have been using

Let's remove "only".

> +    this traditional Unix permission bits for decades and so they find it

Maybe you meant "these" here.

With these changes made,
Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

> +    easier to understand the octal notation than the symbolic macros.
> +    For example, it is harder to read S_IWUSR|S_IRUGO than 0644, which
> +    obscures the developer's intent rather than clarifying it.
> +
> +    See: https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
> +
>
>  Spacing and Brackets
>  --------------------
> --
> 2.25.1
>
