Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0694435D04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhJUIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhJUIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:40:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1B3C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:38:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g10so54905edj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hwoj81YxB7VWM7dvncdJ8OpR+NMluH2LlzM00l2Vz3o=;
        b=x9OoWCZce8X0MQUprhV+HZBOWv4OVVRGRgfCJZyDl7r11AMpmH7VBKWLbXV+tPlRHe
         IPmgA4rQJfM9Mu/VtSfgSweq73eJhzHgCh55KB5UzQpsmhhd+HCPfqfvp1s+jUJORAY8
         Z5FNEGF9THBfk5EfnD7Jx0jzCblR5olTZSTuiQK+yY/6U/6jQOVlcJGQKux+sHkKUGFO
         dJwGXk+9BkwvKlPzeKteaGvEO+XjKW+CD+JgpD2Edf1Kj8Kml19r8n/yx9YmxeMMLbt1
         E4LmYWhi4UDOfoxbbThoEaIx2mxo0zr48BETGq/zzrzNWskonqCrCGaiixBMnMarZEet
         9fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hwoj81YxB7VWM7dvncdJ8OpR+NMluH2LlzM00l2Vz3o=;
        b=b4ZPM/k474sj28NvNwxCuCaMhSkmYKVJfl0p7vK9uCf9W3gzaoZ4bvt9JVw5M1lQJU
         BSlPNLnMhyMtynqTC2d53ptSbHjSAyG/C8XLeThKmkx1Fvb5OT97ow60r8e+gVVkyCb6
         Lx4yKfEUoxL4QjRmStIgW/yUbaW0vmoUC2sfNrTyLBDdCP8Du2NjeTeLjXkjWDCvEDbO
         q6j2eeHgdFtkj9wfht9PdL0+iwJXyPLrZDzD/xk1QCJ5oUji8dv2NyqUkX6PNInbasez
         qBZMqEAnePlYQufBSyO2raMbDnQ6dfF8DVLl03SW+hxyRJVEsmanWuQmvldNr1rCkWI1
         Vznw==
X-Gm-Message-State: AOAM533zxN1kiEpr3+/njmFunXu29Fa7su3YkAfBG1FuGLnhbZx0dmvL
        Nkd/ZiUmu8/yhZWwn2dW04Omf0dPgMVKIvZLFapAKQ==
X-Google-Smtp-Source: ABdhPJwFQdOnK6BQKPQss3CSGijkzSbe8n7aukCqg2Irq1R/pFKFX0bG76Afd1HVpET9Kglve4nQKFMZ+w1QG+ONDOQ=
X-Received: by 2002:a17:906:7fc9:: with SMTP id r9mr5380680ejs.542.1634805492770;
 Thu, 21 Oct 2021 01:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211020175747.28449-1-etienne.carriere@linaro.org> <1634764487.047202.2962588.nullmailer@robh.at.kernel.org>
In-Reply-To: <1634764487.047202.2962588.nullmailer@robh.at.kernel.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 21 Oct 2021 10:38:01 +0200
Message-ID: <CAN5uoS-0N_ccKYPCHdf9EPOF4ctmU4rUGFOBxoNH7DOoM0aJDw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On Wed, 20 Oct 2021 at 23:14, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 20 Oct 2021 19:57:46 +0200, Etienne Carriere wrote:
> > Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> > based on an OP-TEE service invocation. The compatible mandates a
> > channel ID defined with property "linaro,optee-channel-id".
> >
> > Cc: devicetree@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v3:
> >  - Add description for linaro,optee-channel-id in patternProperties
> >    specifying protocol can optionaly define a dedicated channel id.
> >  - Fix DTS example (duplicated phandles issue, subnodes ordering)
> >  - Fix typo in DTS example and description comments.
> >
> > Changes since v2:
> >  - Define mandatory property linaro,optee-channel-id
> >  - Rebased on yaml description file
> >
> > Changes since v1:
> >  - Removed modification regarding mboxes property description.
> > ---
> >  .../bindings/firmware/arm,scmi.yaml           | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.example.dt.yaml: sram@51000000: 'optee-shm-section@0' does not match any of the regexes: '^([a-z]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sram/sram.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1544001
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

For info, i've upgraded dtsschemas, tested on v5.15-rc6 but don't get any error.

Yet, i'll fix the DTS example accordingly in the v5.

Regards,
Etienne
