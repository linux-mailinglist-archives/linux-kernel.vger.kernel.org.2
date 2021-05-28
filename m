Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E22394555
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhE1Pp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 11:45:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:46509 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235056AbhE1PpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 11:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622216625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JkJUm5Q5nZldJdHVI3HDwOi/C3EsQjgUPI0rXoYKGUY=;
        b=WmQzFTlhwuUQnRDTGJWCpc5RjgVHlMKc4HojYWR1ktEbpKs4I9aKBmvGA1xGZsbFaRXZ0v
        ZIEJqLVjhu2gDHLk2fkoFlFuvSNi4U1G3Wp4yw6FBDXKXasXVhpKCyYg8CMGo6vmDcxVnG
        IX9Lk+HrILkZagYQp7wdp0Dvwpyv/Q8=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-0fVtIML0MLyN3HLaoNhncA-1;
 Fri, 28 May 2021 17:43:44 +0200
X-MC-Unique: 0fVtIML0MLyN3HLaoNhncA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2IJ+aeKOxXQlipIPlF31/S5C5EqfnoOefyun9L/33w3q193VvZ6eOh8OvHR4VzMmDAC/thOHi+eHX/Kl+HkNMGEPLObKIWPhyc1Pbo09ZYaIEn5fxTK7+SMySCpZ+xk4hIkp3nLSMHGVyPdUQtm9O9FUqcTPSG3aNnn73NLJsO6tGn+9REq1x8UBm0GdmPyRx2LJ0no6C0UwqVSLhoIeo+Z8sm/Y/NUzTZ8mE429nZM/uLFhTTtFnLRvnjAPs9SOtSIoscW+DydfWmopOc9/ChgLj4SXZQ0ICZYULzqwVBUIZzUOjnq6AZbudTCbOgeXsPaW2b1XvfsVz+lEwA7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkJUm5Q5nZldJdHVI3HDwOi/C3EsQjgUPI0rXoYKGUY=;
 b=BjJpfLarvgiwlFnADVenJioWszmlIxOAz3OQYNXLTxHQ4KbRSW40LPo1+Yj8aFTKAb+EUr6JNiYj0PtbGekUruXNz7jK/iDBkokcTkQOoBIq4/burm6q6vL5tnBWszw2kK/Xx0Zdyw6WCdzujGq/ab7YY5nZcSyLcgEdr8baFUahEwShzrwRxmA0kWj9LD8cxV/4gqzTrG8vkFVNCMTPdV8Ju2MSnbBYcBjcWjHjljiZlbqvUCrJcMl8QiYcfohmvdzNh8EktW+ciUJf1Sf6FLZTRQQB+tqONLFVmjGQ/dq9IC2GkIZohT9qbxm/xQKWAQk1Xf2v7XmE9mVOqvH/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: altlinux.org; dkim=none (message not signed)
 header.d=none;altlinux.org; dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB7942.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::13)
 by AM6PR04MB6375.eurprd04.prod.outlook.com (2603:10a6:20b:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 15:43:43 +0000
Received: from AS8PR04MB7942.eurprd04.prod.outlook.com
 ([fe80::607e:30bf:3618:1a9a]) by AS8PR04MB7942.eurprd04.prod.outlook.com
 ([fe80::607e:30bf:3618:1a9a%3]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 15:43:43 +0000
Date:   Fri, 28 May 2021 17:43:39 +0200
From:   Vojtech Pavlik <vojtech@suse.com>
To:     Egor Ignatov <egori@altlinux.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Problem with i8042 and PS/2 keyboard on HP laptop
Message-ID: <20210528154339.GA9116@suse.com>
References: <f586401d-73af-097f-812c-f033a922bfc2@altlinux.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f586401d-73af-097f-812c-f033a922bfc2@altlinux.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [91.219.245.66]
X-ClientProxiedBy: VI1PR04CA0115.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::13) To AS8PR04MB7942.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from suse.com (91.219.245.66) by VI1PR04CA0115.eurprd04.prod.outlook.com (2603:10a6:803:f0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 15:43:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ff925c-2fd2-47d2-b4a4-08d921ef5f35
X-MS-TrafficTypeDiagnostic: AM6PR04MB6375:
X-Microsoft-Antispam-PRVS: <AM6PR04MB637529A293BCC7EF54375923CC229@AM6PR04MB6375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRL1br6jnObKazPlBzt52lHZFMLMcfSOu95KcOODh9g3wP1all6YIm8hIrxhS1kL/bwU0EDE6c9v3ytGvyTF1KsXuxwI8abolPU6UQnyPuQP+0QA1ZzdX9OlKNq9Xp1CjtJ6JFoGK4Ug2ABOW51h5E3EdQ8Y0gwc0HTeJ/D9BfBRYZK0jHIvLsDXQNmCxqDKx1OkkDVmu7+C1F01aO93j/zAuFTdFoAmCvO2ESxkPx3o/6krpOI8BA/1q2szC7GFNsQdLPiEp74140u2PFHcfiPGgf7INZb3emr2G1Nv4+5JNSf14iyS2o+Arkt923EG5g5ZcgWwuKbT1E7J9j8XGJkT7b+M5adCIaKM3JJu0Fu+dHb8scd0+TSK0wCv2FwiPEJW0/csJB+ngM6qW+n6ZNgN+iQ36TjaPnRUW8O/RLyMIJ7IPwXy4PKYYbe4Cj/WWS4GCFAIfMURPeKmfvw1eVgp+BK8FzEOLWk0pVP05Zlxjk0ha54KXYonHQkI/Zv0xQVoxhKuhQiLQwSzDnrpFNtKF+xSvtkcWilOOK1D+WjmZZLB42hbHMlxr91+Oz+EQOrBkl3tsGvEXBYo1caeoe6Hu3two6l/DIf4gbw3P/M0oPc/hg37tHjem84J3Pfpbct1qo4n8FhHxvMFWzV1Jit+VjvIfxMdY1kIRClvmpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7942.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39850400004)(66476007)(38350700002)(66556008)(36756003)(66946007)(478600001)(38100700002)(26005)(55016002)(956004)(6916009)(2616005)(2906002)(86362001)(4326008)(7696005)(52116002)(16526019)(186003)(1076003)(5660300002)(8936002)(33656002)(8676002)(316002)(8886007)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o96b+VVYxeW8OZgU7zQkLm8sNoDmtOGQXvuTDgTuUrElrUcNxnpSXxPnXlf6?=
 =?us-ascii?Q?mEWiMyo+ijxqUPvRoN/H0j3AOErqK2ZOnLnOSFiQDFnz6jYitlFMgJ74ao4H?=
 =?us-ascii?Q?lmphevihmq7dNJdUeRhIcoN71wcrfDj+modcsjqibe1TKxuFcBFchYEGycqM?=
 =?us-ascii?Q?LKRNHPs3G+as0scwaFbubPJLRkOZPq+dd474H/A+BMezVq+zQ+wuVtvk8qdl?=
 =?us-ascii?Q?aQtlZ3BZeurAabVak/sDx0JvcFTbNe0YUNzpQZCOm3GuFtfTRAuP5eew32j5?=
 =?us-ascii?Q?5fxohA4/ynVQfBX/vSHwonZ/ovy2yUUURFpHaKi8/FGK3pVtd4BnI8fHkjHg?=
 =?us-ascii?Q?QRLlUen5o2iVf3avjbazpBYPmttMQjQCkPIJhbAdzYx/0T38kYNDll3c6Mht?=
 =?us-ascii?Q?MhVJNLURk89kYYhFm8IrWpEzJT19JnG6CqDfmSa6KW7BO2XtZ7nVEG1qgQJI?=
 =?us-ascii?Q?b1m/ibqU6QwFspLs/yw6wa3QR8+W7ugaG/XcsSMjBDMbTHVvnPJfMwGSeRWX?=
 =?us-ascii?Q?xgty4qlZP4DHabpLPOuCVnw2LgUYKgw9Yav9AZBYVidAEA9lb5rIKZwpvH5a?=
 =?us-ascii?Q?/0l1h/w9gln0hIgQ0JnEjJNFD089v3aJwuIqV45hYS+XPG9xTS0DmC8+zRbr?=
 =?us-ascii?Q?Lbst6s4lKz1tc9XpP0IzxqVPpN7vOGGujlDe2MFd1RDiLnf3STeaaq63B7N2?=
 =?us-ascii?Q?DPNA5XUpAx0yUksSxF/gOWR9dEjbO/j4dHO40Hk3CWFwb9M8P5Zlugkat/7b?=
 =?us-ascii?Q?a95XTPi9DAp2igk4LBWjJwjmOHmXOK5EQx0r+I7IJqcSNGjq39KqlpgjNrnw?=
 =?us-ascii?Q?B+3tDlHf3x6JbGeo4AUn7JLbl4ZxziuntVXv1I0ly2eMDJO7x0qz9zO641lE?=
 =?us-ascii?Q?2zQGs9mZPDoAucDq42gAbgyRJOU0LDIftdmf+eCT3l+C8QyPeA+9qSuk5kTl?=
 =?us-ascii?Q?Y1kO3PEg3No1hXvnni+KdZ5qIcJQhSMwdYcJc7KLdoX2Uyxlqgk9ZXEK478N?=
 =?us-ascii?Q?DP71owr2Y+3rAF30rmAifs23lGl+PsQ7i8QqEvmLoGUI0qfYZq4Bl2/I5uey?=
 =?us-ascii?Q?vuU8S2Xq5+wFzJYmIL3Cs34Mk0lBrIhONzUg+x/+iqisnr9XMSDEGIoX6NOY?=
 =?us-ascii?Q?2pGxggdCp7aTx8JFzNLd4EV4mgBEXQD/H7cCSlA7l7bnSOmBZ5U6HHzrQE6T?=
 =?us-ascii?Q?5e4qErPYCoP0qU9qKiMop5AdJZ9xEiP2VJX542UlZSms7xDlZK75CMnm3tbX?=
 =?us-ascii?Q?O8imNEbMLMiZFA91MscLpOYka8lFKnxBpWNBNmadOn8MHjbKX2VXlZ46no+U?=
 =?us-ascii?Q?95a5Pmfuyc/PmfAb+XXGOZ22?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ff925c-2fd2-47d2-b4a4-08d921ef5f35
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7942.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 15:43:42.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI/IkT+bw4Cvg+u/rtEtRqgMWPfz9u9JkNqeSRL9tKSMznBfKCYfqz6SmgXEmdFWanhiYCAd2op87GEZNzfccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 05:02:53PM +0300, Egor Ignatov wrote:

Hello Egor,

> I have a problem with the PS/2 keyboard on an HP laptop
> (15s-fq2020ur).  The problem is that after booting the
> system, the keyboard does not work.  But it starts working
> about 10 seconds after pressing any key.
> 
> I looked at the i8042 log and it seems to me that the
> problem is that the driver does not wait for a response to
> the GETID. It receives ACK and immediately sends the
> 0xed command without waiting for ID.

Actually, that's not the case if you look at the logs:

Here we send the GETID command

> [    0.460964] i8042: [1] f2 -> i8042 (kbd-data)

And here we get the ACK for the command back, 10ms later.

> [    0.471708] i8042: [12] fa <- i8042 (interrupt, 0, 1)

Here we wait for half a second, as you can see from the timestamps, and
nothing arrives. No ID data from the keyboard at all.

So here we see that the GETID command timed out, so we try a backup
plan. Some very old keyboards don't support GETID, so we try SETLEDS,
which every keyboard should support.

> [    0.977581] i8042: [518] ed -> i8042 (kbd-data)

[ .... crickets .... ]

There is no answer at all. We should at least get an 'fa' response here,
so that we can send the parameter of the command.

We wait for another 800ms and nothing at all arrives.

And so the atkbd_probe() function gives up and returns failure.

Then it's back to i8042.c's i8042_port_close();

And it issues the WCTR command with 0x64 as a parameter, to disable the
keyboard IRQ (dropping KBDINT = 1).

> [    1.185586] i8042: [726] 60 -> i8042 (command)
> [    1.185686] i8042: [726] 64 -> i8042 (parameter)

And then i8042.c enables the interrupt again, to look for hotplug
(setting KBDINT=1):

> [    1.185842] i8042: [726] 60 -> i8042 (command)
> [    1.185935] i8042: [726] 65 -> i8042 (parameter)

And oh wow, once we kicked the controller by toggling the interrupt
disable/enable, see what's coming in!

The GETID response!

> [    1.185975] i8042: [726] ab <- i8042 (interrupt, 0, 0)

But something is suspicious here, the "0, 0". The last number is the
interrupt number and the KBD port always uses IRQ1.

So this comes from manually checking the port for waiting data by
calling i8042_interrupt(0, NULL); at the end of i8042_port_close().

And the controller that got stuck after the GETID command is unstuck
again and properly generates an interrupt for the 2nd byte of the GETID
response:

> [    1.189909] i8042: [730] 83 <- i8042 (interrupt, 0, 1)

Yay, we got that.

Now an incoming byte on the KBD port triggers a hotplug event, we think
there may be a new keyboard plugged in.

So we repeat the detection sequence of atkbd again, sending the GETID
command:

> [    1.189952] i8042: [730] f2 -> i8042 (kbd-data)

And we get a proper ACK response:

> [    1.200096] i8042: [740] fa <- i8042 (interrupt, 0, 1)

But what the hell, there is one more ACK coming that shouldn't have:

> [    1.204012] i8042: [744] fa <- i8042 (interrupt, 0, 1)

So we bail out. An ID of 0xfa is not a keyboard!

Back to i8042.c, we toggle the interrupt enable bit:

> [    1.204031] i8042: [744] 60 -> i8042 (command)
> [    1.204124] i8042: [744] 64 -> i8042 (parameter)
> [    1.204272] i8042: [744] 60 -> i8042 (command)
> [    1.204364] i8042: [744] 65 -> i8042 (parameter)

But there's nothing waiting for us, so nothing else is happening.

> At this point it doesn't do anything until you press a key.
> Then the driver starts sending GETID repeatedly until at
> some point it gets the correct answer, after which the
> keyboard starts working. As I sad it takes about 10 secs.
> 
> Here is a part of the log after pressing a key:
> 

> [   11.103249] i8042: [10643] 1d <- i8042 (interrupt, 0, 1)

Indeed, a keypress means new bytes coming in, so this is a new hotplug
event - and we try to detect if there is a keyboard:

> [   11.103287] i8042: [10643] f2 -> i8042 (kbd-data)
> [   11.113673] i8042: [10654] fa <- i8042 (interrupt, 0, 1)
> [   11.113719] i8042: [10654] ab <- i8042 (interrupt, 0, 1)

And something goes awry again. We're supposed to get 'fa ab 83', not
just 'fa ab'.

So we wait and timeout 0.5 seconds later. We fall back to trying the
SETLED command again.

> [   11.617485] i8042: [11158] ed -> i8042 (kbd-data)

And we don't even get an ACK. The keyboard controller is stuck again.
Ouch.

> [   11.825485] i8042: [11366] 60 -> i8042 (command)
> [   11.825778] i8042: [11366] 64 -> i8042 (parameter)
> [   11.825924] i8042: [11366] 60 -> i8042 (command)
> [   11.826016] i8042: [11366] 65 -> i8042 (parameter)

So we're back in closing the port in i8042.c. We toggled the line, and
we check for any data in the data port:

> [   11.826049] i8042: [11366] 83 <- i8042 (interrupt, 0, 0)

Yes, like before, the 0x83 was waiting there for us and was blocking the
data port for any further communication.

> [   11.830084] i8042: [11370] fa <- i8042 (interrupt, 0, 1)

And another ACK was waiting there, too, probably from the SETLEDs
command. This time, however, we're lucky and manage to read the ACK
before we start reinitializing the keyboard.

So we send a GETID:

> [   11.830107] i8042: [11370] f2 -> i8042 (kbd-data)

Get an ACK:

> [   11.840241] i8042: [11380] fa <- i8042 (interrupt, 0, 1)

And this I don't even have an idea where is coming from. Possibly still
the keypress ... ?

> [   11.844063] i8042: [11384] 38 <- i8042 (interrupt, 0, 1)

Nevertheless, it's not a valid ID, so we bail out again.

We toggle the interrupt pin.

> [   11.844083] i8042: [11384] 60 -> i8042 (command)
> [   11.844174] i8042: [11384] 64 -> i8042 (parameter)
> [   11.844320] i8042: [11384] 60 -> i8042 (command)
> [   11.844413] i8042: [11384] 65 -> i8042 (parameter)

And this time there is no data stuck there. But some comes later via the
normal interrupt way (still no idea what the keybaord is trying to tell
us, maybe more keypresses):

> [   11.849039] i8042: [11389] 3c <- i8042 (interrupt, 0, 1)

And we try to identify the keyboard ....

> [   11.849059] i8042: [11389] f2 -> i8042 (kbd-data)
> [   11.859198] i8042: [11399] fa <- i8042 (interrupt, 0, 1)
> [   12.361490] i8042: [11902] ed -> i8042 (kbd-data)
> ...
> [   27.516138] i8042: [27455] f2 -> i8042 (kbd-data)
> [   27.526395] i8042: [27466] fa <- i8042 (interrupt, 0, 1)
> [   27.531044] i8042: [27471] fa <- i8042 (interrupt, 0, 1)
> [   27.531080] i8042: [27471] 60 -> i8042 (command)
> [   27.531183] i8042: [27471] 64 -> i8042 (parameter)
> [   27.531336] i8042: [27471] 60 -> i8042 (command)
> [   27.531713] i8042: [27471] 65 -> i8042 (parameter)
> [   27.536215] i8042: [27476] 1d <- i8042 (interrupt, 0, 1)
> **HERE IT FINALLY RECEIVES THE CORRECT RESPONSE**

And indeed, later the sequence finally succeeds:

> [   27.536290] i8042: [27476] f2 -> i8042 (kbd-data)
> [   27.546882] i8042: [27487] fa <- i8042 (interrupt, 0, 1)
> [   27.546940] i8042: [27487] ab <- i8042 (interrupt, 0, 1)
> [   27.546997] i8042: [27487] 83 <- i8042 (interrupt, 0, 1)

We get the correct ID and we proceed to RESET_DIS to prevent any
keypresses messing up our further communication with the keyboard:

> [   27.547018] i8042: [27487] f5 -> i8042 (kbd-data)
> [   27.557566] i8042: [27497] fa <- i8042 (interrupt, 0, 1)

We then turn the LEDs off:

> [   27.557615] i8042: [27497] ed -> i8042 (kbd-data)
> [   27.568242] i8042: [27508] fa <- i8042 (interrupt, 0, 1)
> [   27.568294] i8042: [27508] 00 -> i8042 (kbd-data)
> [   27.578730] i8042: [27518] fa <- i8042 (interrupt, 0, 1)

Set the repeat rate:

> [   27.578785] i8042: [27518] f3 -> i8042 (kbd-data)
> [   27.589151] i8042: [27529] fa <- i8042 (interrupt, 0, 1)
> [   27.589206] i8042: [27529] 00 -> i8042 (kbd-data)
> [   27.599602] i8042: [27539] fa <- i8042 (interrupt, 0, 1)

And finally enable the keyboard for use.

> [   27.599676] i8042: [27539] f4 -> i8042 (kbd-data)
> [   27.609986] i8042: [27550] fa <- i8042 (interrupt, 0, 1)
> 
> Any idea what to do about this?

So it's not the problem that the driver would not be waiting for a GETID
answer. It actually waits for a long long time.

It's the virtual i8042 keyboard controller implemented in the BIOS that
has an issue, not properly delivering interrupts when the keyboard sends
three bytes (fa ab 83) in a too quick succession.

You can try experimenting with the 'noaux', 'nomux' and 'dumbkbd',
and 'kbdreset' options of i8042, and also the 'reset' option of 'atkbd'.

This will change the init sequence and there is a chance it'll stop
tickling the virtual i8042 controller in the laptop the wrong way.

If that helps, there is a quirk table in i8042 to enable these options
based on the EDID data of the laptop automatically.

If it doesn't help, then we'd need to find a workaround how to recover
from the lost IRQ situation without giving up on keyboar detection.

Possibly by signalling the detection timeout from atkbd.c back to
i8042.c to check for a stuck byte in the queue.

Vojtech

-- 
Vojtech Pavlik
VP Linux Systems Group, SUSE 

