Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C5A421F4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhJEHQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:16:27 -0400
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:58156 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232251AbhJEHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:16:26 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C071F1807D7C1;
        Tue,  5 Oct 2021 07:14:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 3DE5B268E45;
        Tue,  5 Oct 2021 07:14:27 +0000 (UTC)
Message-ID: <c56e78bc85cbe6b05dd16c750e596ab331c37dee.camel@perches.com>
Subject: Re: [PATCH V0 4/7] usb: common: eud: Added the driver support for
 Embedded USB Debugger(EUD)
From:   Joe Perches <joe@perches.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Souradeep Chowdhury <schowdhu@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        satyap@codeaurora.org, pheragu@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date:   Tue, 05 Oct 2021 00:14:25 -0700
In-Reply-To: <YVsu602phHbZLMOT@ripper>
References: <cover.1633343547.git.schowdhu@codeaurora.org>
         <e6df4a21a283e822d15dedb7ffb3ae62c241999c.1633343547.git.schowdhu@codeaurora.org>
         <YVsu602phHbZLMOT@ripper>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3DE5B268E45
X-Spam-Status: No, score=-2.03
X-Stat-Signature: p41cre9disuxr4e5bn6qwko7y6z19gz4
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/wX7nCYcBjYI3ylpNeDbHYE4g46+Sy/Cw=
X-HE-Tag: 1633418067-584561
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-04 at 09:42 -0700, Bjorn Andersson wrote:
> On Mon 04 Oct 04:16 PDT 2021, Souradeep Chowdhury wrote:
> 
> > Add support for control peripheral of EUD (Embedded USB Debugger) to
> > listen to events such as USB attach/detach, pet EUD to indicate software
> > is functional.Reusing the platform device kobj, sysfs entry 'enable' is
> > created to enable or disable EUD.
[]
> > diff --git a/drivers/usb/common/qcom_eud.c b/drivers/usb/common/qcom_eud.c
[]
> > +static ssize_t enable_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct eud_chip *chip = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "%d", chip->enable);

trivia:

should probably use sysfs_emit and have a trailing '\n' in the format.


