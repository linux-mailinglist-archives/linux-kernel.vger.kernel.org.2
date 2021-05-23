Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B605338D834
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEWCEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhEWCEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:04:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:03:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c20so23827720qkm.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjnZ0zgQnYl6m6VonMK5rveRNEm88gewG9BMTvlY4rc=;
        b=UmaA1luOdT4X1XAgd15hg3PNAfMIIrLsF0VfAhH20AjQVHSdQcCnMC1vdYN3t5MJWe
         qTUyNeBQBkGpGBslHutT/fLmzGi6iiQ1iq01tx4MwESclm0oBntAU2SJIPtHJsU81LBE
         S9QObIlM2ud0S9v8q9lUNXfGz33MAnLSCZZCM+4udTzJI1fkCR8Bc5a2PukirI1Xt3MY
         RjfMuTuyDgAyMssdh8yCOo/aenkfFit4hYUCjiMrbA6QITyTjZkQXwKKS8kS+Ere8NDI
         vjgn5DbcTYAZa7k9B/C22Ihgguj+G6V4Ybicr/q64vFreYCT8mw73QPUKEqt2Cj2xUsq
         RzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjnZ0zgQnYl6m6VonMK5rveRNEm88gewG9BMTvlY4rc=;
        b=S90oNP03kOZksUAbpU4w9bDJNm9P5ABr19Fqx+b0vDA6sKbRrmFO021hWt4o4jpwlU
         33shrybLzx9WqsG8AlI7tUKwGXkjtB4gelRwUaWPHpImZuS1yC0gdx1DgraAnHJ7E7Qk
         udTYfWc9uswtTEiwU80gSVjbVDB4CIBv86NBtp4P5mLBfnkKjb2EIsSgqLoGXXJEsSQ1
         tiXtDoju3dRKGLzWbt/4TLL3EmTvDCYTQEjaK/K33MIIi+XJ4tV5g4GyY8CIxHkySj+n
         LtM0OsygQhW119gLssQCycDg9bMRCP7cOiCItlO8JrfP/oB0nhr8bSC0JbkD67CySoTt
         bomg==
X-Gm-Message-State: AOAM5322XO7NZzWFwOyH/nawny2+F9CbG6lzWLR3EZ22+lPODtRpk3XJ
        EakNC6s2A9J8RzEktyr+tgIwiIpQzPCAk+dIx33NkjruRLiNIw==
X-Google-Smtp-Source: ABdhPJzIZlplEk5BnR+2417JjoqZgLRQD+Dtbb3xCtYBZGimpk0zMKjiMGOgMPRNKt7Rwddjfa1MZ2ZlHkT4AkR5F3g=
X-Received: by 2002:a05:620a:22f2:: with SMTP id p18mr21711713qki.410.1621735394659;
 Sat, 22 May 2021 19:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210521130121.1470334-2-kyletso@google.com> <202105230455.faAHm2qT-lkp@intel.com>
In-Reply-To: <202105230455.faAHm2qT-lkp@intel.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Sun, 23 May 2021 10:02:58 +0800
Message-ID: <CAGZ6i=2SDOWMHVOt0B6bn5=sxKgPR2cvgEX4uXXxJxN67GtLEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: typec: tcpm: Properly interrupt VDM AMS
To:     kernel test robot <lkp@intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 4:23 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Kyle,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on usb/usb-testing]
> [also build test WARNING on v5.13-rc2 next-20210521]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Kyle-Tso/Fix-some-VDM-AMS-handling/20210522-205431
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> config: x86_64-randconfig-a006-20210523 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project e84a9b9bb3051c35dea993cdad7b3d2575638f85)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/6e05980ae46e87d0a409e1e653658ae6fd7b3a32
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Kyle-Tso/Fix-some-VDM-AMS-handling/20210522-205431
>         git checkout 6e05980ae46e87d0a409e1e653658ae6fd7b3a32
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/usb/typec/tcpm/tcpm.c:2326:19: warning: equality comparison result unused [-Wunused-comparison]
>                    port->vdm_state == VDM_STATE_ERR_BUSY;
>                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
>    drivers/usb/typec/tcpm/tcpm.c:2326:19: note: use '=' to turn this equality comparison into an assignment
>                    port->vdm_state == VDM_STATE_ERR_BUSY;
>                                    ^~
>                                    =
>    1 warning generated.
>
>

Fixed in v2
https://lore.kernel.org/linux-usb/20210523015855.1785484-1-kyletso@google.com/

thanks,
Kyle

> vim +2326 drivers/usb/typec/tcpm/tcpm.c
>
>   2313
>   2314  static void tcpm_pd_data_request(struct tcpm_port *port,
>   2315                                   const struct pd_message *msg)
>   2316  {
>   2317          enum pd_data_msg_type type = pd_header_type_le(msg->header);
>   2318          unsigned int cnt = pd_header_cnt_le(msg->header);
>   2319          unsigned int rev = pd_header_rev_le(msg->header);
>   2320          unsigned int i;
>   2321          enum frs_typec_current partner_frs_current;
>   2322          bool frs_enable;
>   2323          int ret;
>   2324
>   2325          if (tcpm_vdm_ams(port) && type != PD_DATA_VENDOR_DEF) {
> > 2326                  port->vdm_state == VDM_STATE_ERR_BUSY;
>   2327                  tcpm_ams_finish(port);
>   2328                  mod_vdm_delayed_work(port, 0);
>   2329          }
>   2330
>   2331          switch (type) {
>   2332          case PD_DATA_SOURCE_CAP:
>   2333                  for (i = 0; i < cnt; i++)
>   2334                          port->source_caps[i] = le32_to_cpu(msg->payload[i]);
>   2335
>   2336                  port->nr_source_caps = cnt;
>   2337
>   2338                  tcpm_log_source_caps(port);
>   2339
>   2340                  tcpm_validate_caps(port, port->source_caps,
>   2341                                     port->nr_source_caps);
>   2342
>   2343                  /*
>   2344                   * Adjust revision in subsequent message headers, as required,
>   2345                   * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
>   2346                   * support Rev 1.0 so just do nothing in that scenario.
>   2347                   */
>   2348                  if (rev == PD_REV10) {
>   2349                          if (port->ams == GET_SOURCE_CAPABILITIES)
>   2350                                  tcpm_ams_finish(port);
>   2351                          break;
>   2352                  }
>   2353
>   2354                  if (rev < PD_MAX_REV)
>   2355                          port->negotiated_rev = rev;
>   2356
>   2357                  if (port->pwr_role == TYPEC_SOURCE) {
>   2358                          if (port->ams == GET_SOURCE_CAPABILITIES)
>   2359                                  tcpm_pd_handle_state(port, SRC_READY, NONE_AMS, 0);
>   2360                          /* Unexpected Source Capabilities */
>   2361                          else
>   2362                                  tcpm_pd_handle_msg(port,
>   2363                                                     port->negotiated_rev < PD_REV30 ?
>   2364                                                     PD_MSG_CTRL_REJECT :
>   2365                                                     PD_MSG_CTRL_NOT_SUPP,
>   2366                                                     NONE_AMS);
>   2367                  } else if (port->state == SNK_WAIT_CAPABILITIES) {
>   2368                  /*
>   2369                   * This message may be received even if VBUS is not
>   2370                   * present. This is quite unexpected; see USB PD
>   2371                   * specification, sections 8.3.3.6.3.1 and 8.3.3.6.3.2.
>   2372                   * However, at the same time, we must be ready to
>   2373                   * receive this message and respond to it 15ms after
>   2374                   * receiving PS_RDY during power swap operations, no matter
>   2375                   * if VBUS is available or not (USB PD specification,
>   2376                   * section 6.5.9.2).
>   2377                   * So we need to accept the message either way,
>   2378                   * but be prepared to keep waiting for VBUS after it was
>   2379                   * handled.
>   2380                   */
>   2381                          port->ams = POWER_NEGOTIATION;
>   2382                          port->in_ams = true;
>   2383                          tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
>   2384                  } else {
>   2385                          if (port->ams == GET_SOURCE_CAPABILITIES)
>   2386                                  tcpm_ams_finish(port);
>   2387                          tcpm_pd_handle_state(port, SNK_NEGOTIATE_CAPABILITIES,
>   2388                                               POWER_NEGOTIATION, 0);
>   2389                  }
>   2390                  break;
>   2391          case PD_DATA_REQUEST:
>   2392                  /*
>   2393                   * Adjust revision in subsequent message headers, as required,
>   2394                   * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
>   2395                   * support Rev 1.0 so just reject in that scenario.
>   2396                   */
>   2397                  if (rev == PD_REV10) {
>   2398                          tcpm_pd_handle_msg(port,
>   2399                                             port->negotiated_rev < PD_REV30 ?
>   2400                                             PD_MSG_CTRL_REJECT :
>   2401                                             PD_MSG_CTRL_NOT_SUPP,
>   2402                                             NONE_AMS);
>   2403                          break;
>   2404                  }
>   2405
>   2406                  if (rev < PD_MAX_REV)
>   2407                          port->negotiated_rev = rev;
>   2408
>   2409                  if (port->pwr_role != TYPEC_SOURCE || cnt != 1) {
>   2410                          tcpm_pd_handle_msg(port,
>   2411                                             port->negotiated_rev < PD_REV30 ?
>   2412                                             PD_MSG_CTRL_REJECT :
>   2413                                             PD_MSG_CTRL_NOT_SUPP,
>   2414                                             NONE_AMS);
>   2415                          break;
>   2416                  }
>   2417
>   2418                  port->sink_request = le32_to_cpu(msg->payload[0]);
>   2419
>   2420                  if (port->vdm_sm_running && port->explicit_contract) {
>   2421                          tcpm_pd_handle_msg(port, PD_MSG_CTRL_WAIT, port->ams);
>   2422                          break;
>   2423                  }
>   2424
>   2425                  if (port->state == SRC_SEND_CAPABILITIES)
>   2426                          tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
>   2427                  else
>   2428                          tcpm_pd_handle_state(port, SRC_NEGOTIATE_CAPABILITIES,
>   2429                                               POWER_NEGOTIATION, 0);
>   2430                  break;
>   2431          case PD_DATA_SINK_CAP:
>   2432                  /* We don't do anything with this at the moment... */
>   2433                  for (i = 0; i < cnt; i++)
>   2434                          port->sink_caps[i] = le32_to_cpu(msg->payload[i]);
>   2435
>   2436                  partner_frs_current = (port->sink_caps[0] & PDO_FIXED_FRS_CURR_MASK) >>
>   2437                          PDO_FIXED_FRS_CURR_SHIFT;
>   2438                  frs_enable = partner_frs_current && (partner_frs_current <=
>   2439                                                       port->new_source_frs_current);
>   2440                  tcpm_log(port,
>   2441                           "Port partner FRS capable partner_frs_current:%u port_frs_current:%u enable:%c",
>   2442                           partner_frs_current, port->new_source_frs_current, frs_enable ? 'y' : 'n');
>   2443                  if (frs_enable) {
>   2444                          ret  = port->tcpc->enable_frs(port->tcpc, true);
>   2445                          tcpm_log(port, "Enable FRS %s, ret:%d\n", ret ? "fail" : "success", ret);
>   2446                  }
>   2447
>   2448                  port->nr_sink_caps = cnt;
>   2449                  port->sink_cap_done = true;
>   2450                  if (port->ams == GET_SINK_CAPABILITIES)
>   2451                          tcpm_set_state(port, ready_state(port), 0);
>   2452                  /* Unexpected Sink Capabilities */
>   2453                  else
>   2454                          tcpm_pd_handle_msg(port,
>   2455                                             port->negotiated_rev < PD_REV30 ?
>   2456                                             PD_MSG_CTRL_REJECT :
>   2457                                             PD_MSG_CTRL_NOT_SUPP,
>   2458                                             NONE_AMS);
>   2459                  break;
>   2460          case PD_DATA_VENDOR_DEF:
>   2461                  tcpm_handle_vdm_request(port, msg->payload, cnt);
>   2462                  break;
>   2463          case PD_DATA_BIST:
>   2464                  port->bist_request = le32_to_cpu(msg->payload[0]);
>   2465                  tcpm_pd_handle_state(port, BIST_RX, BIST, 0);
>   2466                  break;
>   2467          case PD_DATA_ALERT:
>   2468                  tcpm_handle_alert(port, msg->payload, cnt);
>   2469                  break;
>   2470          case PD_DATA_BATT_STATUS:
>   2471          case PD_DATA_GET_COUNTRY_INFO:
>   2472                  /* Currently unsupported */
>   2473                  tcpm_pd_handle_msg(port, port->negotiated_rev < PD_REV30 ?
>   2474                                     PD_MSG_CTRL_REJECT :
>   2475                                     PD_MSG_CTRL_NOT_SUPP,
>   2476                                     NONE_AMS);
>   2477                  break;
>   2478          default:
>   2479                  tcpm_pd_handle_msg(port, port->negotiated_rev < PD_REV30 ?
>   2480                                     PD_MSG_CTRL_REJECT :
>   2481                                     PD_MSG_CTRL_NOT_SUPP,
>   2482                                     NONE_AMS);
>   2483                  tcpm_log(port, "Unrecognized data message type %#x", type);
>   2484                  break;
>   2485          }
>   2486  }
>   2487
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
