Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F43F3EAD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhHVIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 04:46:35 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:43048 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231147AbhHVIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 04:46:34 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 554F11803893D;
        Sun, 22 Aug 2021 08:45:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id E0A5120A297;
        Sun, 22 Aug 2021 08:45:50 +0000 (UTC)
Message-ID: <12a41a13f8d03a16c3d5c20710a901c090b7d244.camel@perches.com>
Subject: Re: [PATCH] vsprintf and docs: Add X to %ph for upper case output
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 22 Aug 2021 01:45:49 -0700
In-Reply-To: <CAHp75Vdh2CP9n0FrU+6nkmzVWKoKD6RN-RGv7Z+UD_KUoFXPfw@mail.gmail.com>
References: <6abd83d11f1daa3094f82e92843e8279f302e349.camel@perches.com>
         <CAHp75Vdh2CP9n0FrU+6nkmzVWKoKD6RN-RGv7Z+UD_KUoFXPfw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E0A5120A297
X-Stat-Signature: 5xq3nkycjjd5n7oa7haaj1ys1k77u6ud
X-Spam-Status: No, score=-1.36
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+5/U6GonMEN9W3NGgqoM7MjYGf8g8TEwg=
X-HE-Tag: 1629621950-549273
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-22 at 11:31 +0300, Andy Shevchenko wrote:
> On Sun, Aug 22, 2021 at 6:00 AM Joe Perches <joe@perches.com> wrote:
> > 
> > Uppercase hex output of small char arrays is moderately frequently used.
> > Add a mechanism to support the %*ph output as uppercase using 'X'.
> 
> Besides the fact of existing hex_asc_upper_*(), what ABI (!) uses
> this? If none, I dunno we need this.
> And show at least a few users where we gain something after conversion.
> 

There are at least a few uses that could be converted.

For instance:

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 3faa87fa296a2..c56871e8ce1b7 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -743,13 +743,7 @@ static ssize_t unique_id_show(struct device *dev,
 	}
 	memcpy(sn, hdev->device_id, sizeof(sn));
 	spin_unlock_irqrestore(&h->lock, flags);
-	return snprintf(buf, 16 * 2 + 2,
-			"%02X%02X%02X%02X%02X%02X%02X%02X"
-			"%02X%02X%02X%02X%02X%02X%02X%02X\n",
-			sn[0], sn[1], sn[2], sn[3],
-			sn[4], sn[5], sn[6], sn[7],
-			sn[8], sn[9], sn[10], sn[11],
-			sn[12], sn[13], sn[14], sn[15]);
+	return snprintf(buf, 16 * 2 + 2, "%16phNX\n", sn);
 }
 
 static ssize_t sas_address_show(struct device *dev,

and

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ecb2af3f43ca3..eb39490b196cc 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6674,13 +6674,7 @@ static ssize_t pqi_unique_id_show(struct device *dev,
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
-	return scnprintf(buffer, PAGE_SIZE,
-		"%02X%02X%02X%02X%02X%02X%02X%02X"
-		"%02X%02X%02X%02X%02X%02X%02X%02X\n",
-		unique_id[0], unique_id[1], unique_id[2], unique_id[3],
-		unique_id[4], unique_id[5], unique_id[6], unique_id[7],
-		unique_id[8], unique_id[9], unique_id[10], unique_id[11],
-		unique_id[12], unique_id[13], unique_id[14], unique_id[15]);
+	return scnprintf(buffer, PAGE_SIZE, "%16phNX\n", unique_id);
 }


